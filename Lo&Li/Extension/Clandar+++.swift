//
//  Clandar+++.swift
//  Looper
//
//  Created by 赵翔宇 on 2022/6/24.
//

// 返回范围内指定Component的的日期...
extension Calendar {
    func getDatesIn(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in

            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}

extension DateInterval {
    static let year = Calendar.current.dateInterval(of: .year, for: Date())
    static let month = Calendar.current.dateInterval(of: .month, for: Date())
    static let day = Calendar.current.dateInterval(of: .day, for: Date())
}
