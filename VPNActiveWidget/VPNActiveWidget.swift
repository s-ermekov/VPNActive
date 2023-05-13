//
//  VPNActiveWidget.swift
//  VPNActiveWidget
//
//  Created by Санжар Эрмеков on 11.05.2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> VPNEntry {
        VPNEntry(date: Date(), vpnStatus: true, model: nil, configuration: ConfigurationIntent())
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (VPNEntry) -> ()) {
        let entry = VPNEntry(date: Date(), vpnStatus: true, model: nil, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Model.fetchData { model, error in
            if let error { print("DEBUG: Timeline. Model Fetch Error. Localized Description: \(error.localizedDescription)") }
            if let model {
                let vpnStatus = VPNChecker.vpnActive()
                let date: Date = .now
                let entry = VPNEntry(date: date, vpnStatus: vpnStatus, model: model, configuration: configuration)
                let timeline = Timeline(entries: [entry], policy: .after(date.advanced(by: 60 * 10)))
                completion(timeline)
            }
        }
    }
}

struct VPNEntry: TimelineEntry {
    let date: Date
    let vpnStatus: Bool
    let model: Model?
    let configuration: ConfigurationIntent
}

struct VPNActiveWidgetEntryView : View {
    var entry: Provider.Entry
    
    var backgroundView: some View {
        ContainerRelativeShape()
            .fill(Color("widgetBackground"))
            .overlay {
                if entry.vpnStatus {
                    ContainerRelativeShape()
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [.green, .orange, .green, .red, .green]),
                                center: .center,
                                startAngle: .zero,
                                endAngle: .degrees(270)
                            ),
                            style: StrokeStyle(lineWidth: 13)
                        )
                } else {
                    ContainerRelativeShape()
                        .stroke(.gray, lineWidth: 13)
                }
            }
    }

    var body: some View {
        ZStack {
            backgroundView
            VStack(alignment: .leading) {
                HStack {
                    Text("Is VPN active?")
                        .foregroundColor(.gray)
                        .italic()
                        .font(.system(size: 14, weight: .medium))
                    Spacer()
                }
                .padding(.bottom, 6)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Status: \(entry.vpnStatus ? AttributedString("ON").thin : AttributedString("OFF").thin)")
                        .minimumScaleFactor(0.6)
                    if let model = entry.model {
                        if let ip = model.ip {
                            Text("IP: \(AttributedString(ip).thin)")
                                .font(.subheadline)
                                .minimumScaleFactor(0.6)
                        }
                        if let city = model.city, let country = model.country_code {
                            Text("City: \(AttributedString(city).thin) \(country.emoji)")
                                .minimumScaleFactor(0.6)
                        }
                    }
                }
                .font(.system(size: 16))
                Spacer()
                HStack(spacing: 3) {
                    Spacer()
                    Image(systemName: "info.circle")
                    Text("ipapi.co")
                        .italic()
                }
                .foregroundColor(.gray)
                .font(.system(size: 12))
            }
            .padding([.top, .leading, .trailing], 22)
            .padding(.bottom, 14)
        }
        .widgetURL(URL(string: "vpnactive://update"))
    }
}


struct VPNActiveWidget: Widget {
    let kind: String = "VPN Active Widget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            VPNActiveWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("VPN Active Widget")
        .description("Shows your current IP address and VPN status.")
        .supportedFamilies([.systemSmall])
    }
}

struct VPNActiveWidget_Previews: PreviewProvider {
    static var previews: some View {
        VPNActiveWidgetEntryView(entry: VPNEntry(date: Date(), vpnStatus: true, model: Model.bishkek, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        VPNActiveWidgetEntryView(entry: VPNEntry(date: Date(), vpnStatus: false, model: Model.bishkek, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
