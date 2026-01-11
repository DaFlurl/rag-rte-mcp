package com.evony.useful.templates {
    public class TimeCalculator {
        // Base times in minutes
        private static const BUILD_TIMES:Object = {
            cottage: [5, 10, 20, 40, 80, 160, 320, 640, 1280, 2560],
            barracks: [10, 20, 40, 80, 160, 320, 640, 1280, 2560, 5120],
            wall: [15, 30, 60, 120, 240, 480, 960, 1920, 3840, 7680],
            warehouse: [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096],
            farm: [6, 12, 24, 48, 96, 192, 384, 768, 1536, 3072],
            sawmill: [6, 12, 24, 48, 96, 192, 384, 768, 1536, 3072],
            ironmine: [6, 12, 24, 48, 96, 192, 384, 768, 1536, 3072],
            quarry: [6, 12, 24, 48, 96, 192, 384, 768, 1536, 3072]
        };
        
        // Research times in minutes
        private static const RESEARCH_TIMES:Object = {
            military: [30, 60, 120, 240, 480, 960, 1920, 3840, 7680, 15360],
            economy: [20, 40, 80, 160, 320, 640, 1280, 2560, 5120, 10240],
            defense: [25, 50, 100, 200, 400, 800, 1600, 3200, 6400, 12800]
        };
        
        // March speeds (tiles per minute)
        private static const MARCH_SPEEDS:Object = {
            warrior: 20,
            pike: 20,
            sword: 20,
            archer: 20,
            cavalry: 40,
            cataphract: 30,
            ballista: 10,
            transporter: 15,
            scout: 60
        };
        
        /**
         * Calculate build times
         */
        public static function calculateBuildTime(
            builds:Array // Array of {type, level, count}
        ):Object {
            var times:Object = {
                total: 0,
                byType: {},
                parallel: 0,
                sequential: 0,
                recommendations: []
            };
            
            for each (var build:Object in builds) {
                if (BUILD_TIMES[build.type]) {
                    var time:Number = BUILD_TIMES[build.type][
                        build.level - 1
                    ] * build.count;
                    
                    times.byType[build.type] = time;
                    times.total += time;
                }
            }
            
            // Calculate parallel vs sequential
            times.sequential = times.total;
            times.parallel = calculateParallelTime(times.byType);
            
            // Add recommendations
            if (times.sequential > 1440) { // More than 24 hours
                times.recommendations.push(
                    "Consider splitting construction across multiple days"
                );
            }
            
            if (times.parallel < times.sequential * 0.5) {
                times.recommendations.push(
                    "Parallel construction could save " + 
                    Math.floor((times.sequential - times.parallel) / 60) + 
                    " hours"
                );
            }
            
            return times;
        }
        
        /**
         * Calculate research times
         */
        public static function calculateResearchTime(
            research:Array // Array of {type, level}
        ):Object {
            var times:Object = {
                total: 0,
                byType: {},
                withBuffs: {},
                recommendations: []
            };
            
            for each (var item:Object in research) {
                if (RESEARCH_TIMES[item.type]) {
                    var time:Number = RESEARCH_TIMES[item.type][
                        item.level - 1
                    ];
                    
                    times.byType[item.type] = time;
                    times.total += time;
                }
            }
            
            // Calculate times with buffs
            times.withBuffs = calculateBuffedTimes(times.byType);
            
            // Add recommendations
            if (times.total > 2880) { // More than 48 hours
                times.recommendations.push(
                    "Long research time - consider using speed buffs"
                );
            }
            
            return times;
        }
        
        /**
         * Calculate march times
         */
        public static function calculateMarchTime(
            data:Object // {units, distance, buffs}
        ):Object {
            var march:Object = {
                baseTime: 0,
                buffedTime: 0,
                limitingUnit: "",
                waves: [],
                recommendations: []
            };
            
            // Find slowest unit
            var slowestSpeed:Number = Number.MAX_VALUE;
            for (var unit:String in data.units) {
                if (data.units[unit] > 0 && MARCH_SPEEDS[unit]) {
                    var speed:Number = MARCH_SPEEDS[unit];
                    if (speed < slowestSpeed) {
                        slowestSpeed = speed;
                        march.limitingUnit = unit;
                    }
                }
            }
            
            // Calculate times
            march.baseTime = data.distance / slowestSpeed;
            march.buffedTime = calculateBuffedMarchTime(
                march.baseTime,
                data.buffs
            );
            
            // Calculate wave timing if needed
            if (data.units[march.limitingUnit] > 700000000) { // Safe limit
                march.waves = calculateMarchWaves(
                    data.units,
                    data.distance
                );
            }
            
            // Add recommendations
            if (march.waves.length > 0) {
                march.recommendations.push(
                    "Large army - split into " + march.waves.length + " waves"
                );
            }
            
            if (march.baseTime > 60) { // More than 1 hour
                march.recommendations.push(
                    "Consider using march speed buffs"
                );
            }
            
            return march;
        }
        
        /**
         * Calculate buff durations and timing
         */
        public static function calculateBuffTiming(
            buffs:Array // Array of {type, duration, startTime}
        ):Object {
            var timing:Object = {
                schedule: [],
                gaps: [],
                overlaps: [],
                recommendations: []
            };
            
            // Sort buffs by start time
            buffs.sort(function(a:Object, b:Object):Number {
                return a.startTime - b.startTime;
            });
            
            // Create timeline
            var timeline:Array = [];
            for each (var buff:Object in buffs) {
                timeline.push({
                    time: buff.startTime,
                    type: "start",
                    buff: buff
                });
                timeline.push({
                    time: buff.startTime + buff.duration,
                    type: "end",
                    buff: buff
                });
            }
            
            // Sort timeline
            timeline.sort(function(a:Object, b:Object):Number {
                return a.time - b.time;
            });
            
            // Analyze timeline
            var activeBuffs:Array = [];
            var lastTime:Number = 0;
            
            for each (var event:Object in timeline) {
                // Check for gaps
                if (activeBuffs.length == 0 && event.time > lastTime) {
                    timing.gaps.push({
                        start: lastTime,
                        end: event.time
                    });
                }
                
                // Update active buffs
                if (event.type == "start") {
                    activeBuffs.push(event.buff);
                    if (activeBuffs.length > 1) {
                        timing.overlaps.push({
                            time: event.time,
                            buffs: activeBuffs.slice()
                        });
                    }
                } else {
                    var index:int = activeBuffs.indexOf(event.buff);
                    if (index != -1) {
                        activeBuffs.splice(index, 1);
                    }
                }
                
                lastTime = event.time;
            }
            
            // Generate schedule
            timing.schedule = generateBuffSchedule(buffs);
            
            // Add recommendations
            if (timing.gaps.length > 0) {
                timing.recommendations.push(
                    "Found " + timing.gaps.length + " gaps in buff coverage"
                );
            }
            
            if (timing.overlaps.length > 0) {
                timing.recommendations.push(
                    "Found " + timing.overlaps.length + " buff overlaps"
                );
            }
            
            return timing;
        }
        
        // Helper functions
        private static function calculateParallelTime(times:Object):Number {
            var maxTime:Number = 0;
            for (var type:String in times) {
                maxTime = Math.max(maxTime, times[type]);
            }
            return maxTime;
        }
        
        private static function calculateBuffedTimes(times:Object):Object {
            var buffed:Object = {};
            for (var type:String in times) {
                buffed[type] = times[type] * 0.8; // Assume 20% research buff
            }
            return buffed;
        }
        
        private static function calculateBuffedMarchTime(
            time:Number,
            buffs:Object
        ):Number {
            var multiplier:Number = 1;
            
            if (buffs) {
                if (buffs.marchSpeed) {
                    multiplier *= (1 - buffs.marchSpeed);
                }
                if (buffs.alliance) {
                    multiplier *= (1 - buffs.alliance);
                }
            }
            
            return time * multiplier;
        }
        
        private static function calculateMarchWaves(
            units:Object,
            distance:Number
        ):Array {
            var waves:Array = [];
            const SAFE_LIMIT:Number = 700000000;
            
            for (var unit:String in units) {
                var remaining:Number = units[unit];
                while (remaining > 0) {
                    var amount:Number = Math.min(remaining, SAFE_LIMIT);
                    waves.push({
                        unit: unit,
                        amount: amount,
                        time: distance / MARCH_SPEEDS[unit]
                    });
                    remaining -= amount;
                }
            }
            
            return waves;
        }
        
        private static function generateBuffSchedule(buffs:Array):Array {
            var schedule:Array = [];
            var currentTime:Number = 0;
            
            for each (var buff:Object in buffs) {
                schedule.push({
                    type: buff.type,
                    start: currentTime,
                    end: currentTime + buff.duration
                });
                currentTime += buff.duration;
            }
            
            return schedule;
        }
    }
}
