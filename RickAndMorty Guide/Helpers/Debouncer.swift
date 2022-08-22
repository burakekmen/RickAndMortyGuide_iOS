//
//  Debouncer.swift
//  RickAndMorty Guide
//
//  Created by Burak Ekmen on 16.05.2022.
//

import Foundation

class Debouncer {

    private var blockToRun: (() -> Void)?

    private var timeIntervalDebounce: TimeInterval

    private var timerRunBlockToRun: Timer?

    init(timeIntervalDebounce: TimeInterval) {
        self.timeIntervalDebounce = timeIntervalDebounce
    }

    func bounceWithBlock(blockToRun: (() -> Void)?) {
        self.blockToRun = blockToRun
        setBouncingSchedule()
    }

    func cancelScheduledBlock() {
        timerRunBlockToRun?.invalidate()
    }

    private func setBouncingSchedule() {
        cancelScheduledBlock()
        timerRunBlockToRun = Timer.scheduledTimer(timeInterval: timeIntervalDebounce,
                                                  target: self,
                                                  selector: #selector(runBlockToRun),
                                                  userInfo: nil,
                                                  repeats: false)
    }

    @objc private func runBlockToRun() {
        blockToRun?()
    }
}

