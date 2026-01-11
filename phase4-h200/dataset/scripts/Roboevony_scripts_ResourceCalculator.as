package com.evony.useful.templates {
    public class ResourceCalculator {
        // Resource production rates per level
        private static const PRODUCTION_RATES:Object = {
            farm: [200, 400, 800, 1600, 3200, 6400, 12800, 25600, 51200, 102400],
            lumber: [180, 360, 720, 1440, 2880, 5760, 11520, 23040, 46080, 92160],
            iron: [160, 320, 640, 1280, 2560, 5120, 10240, 20480, 40960, 81920],
            stone: [140, 280, 560, 1120, 2240, 4480, 8960, 17920, 35840, 71680]
        };
        
        // Food consumption rates per troop type
        private static const FOOD_RATES:Object = {
            worker: 1,
            warrior: 2,
            scout: 2,
            pike: 2,
            sword: 3,
            archer: 3,
            cavalry: 4,
            cataphract: 6,
            ballista: 5,
            transporter: 4
        };
        
        /**
         * Calculate total resource production
         */
        public static function calculateProduction(
            buildings:Array // Array of {type, level, count}
        ):Object {
            var production:Object = {
                food: 0,
                lumber: 0,
                iron: 0,
                stone: 0,
                perHour: {},
                perDay: {},
                withBuffs: {}
            };
            
            for each (var building:Object in buildings) {
                if (PRODUCTION_RATES[building.type]) {
                    var rate:Number = PRODUCTION_RATES[building.type][
                        building.level - 1
                    ];
                    production[building.type] += rate * building.count;
                }
            }
            
            // Calculate time-based production
            for (var resource:String in production) {
                if (resource != "perHour" && 
                    resource != "perDay" && 
                    resource != "withBuffs") {
                    production.perHour[resource] = production[resource];
                    production.perDay[resource] = production[resource] * 24;
                }
            }
            
            return production;
        }
        
        /**
         * Calculate food consumption
         */
        public static function calculateConsumption(
            troops:Object // {type: count}
        ):Object {
            var consumption:Object = {
                perHour: 0,
                perDay: 0,
                perWeek: 0,
                byType: {}
            };
            
            // Calculate consumption by troop type
            for (var type:String in troops) {
                if (FOOD_RATES[type]) {
                    var rate:Number = FOOD_RATES[type] * troops[type];
                    consumption.byType[type] = rate;
                    consumption.perHour += rate;
                }
            }
            
            // Calculate time-based consumption
            consumption.perDay = consumption.perHour * 24;
            consumption.perWeek = consumption.perDay * 7;
            
            return consumption;
        }
        
        /**
         * Calculate transport capacity
         */
        public static function calculateTransport(
            data:Object // {transporters, distance, resources}
        ):Object {
            var capacity:Object = {
                totalCapacity: 0,
                trips: 0,
                timePerTrip: 0,
                totalTime: 0,
                recommendations: []
            };
            
            // Base capacity per transporter
            const BASE_CAPACITY:Number = 5000;
            const SPEED:Number = 20; // units per minute
            
            // Calculate total capacity
            capacity.totalCapacity = data.transporters * BASE_CAPACITY;
            
            // Calculate trips needed
            var totalResources:Number = 0;
            for (var resource:String in data.resources) {
                totalResources += data.resources[resource];
            }
            
            capacity.trips = Math.ceil(totalResources / capacity.totalCapacity);
            
            // Calculate timing
            capacity.timePerTrip = (data.distance / SPEED) * 2; // Round trip
            capacity.totalTime = capacity.timePerTrip * capacity.trips;
            
            // Add recommendations
            if (capacity.trips > 1) {
                capacity.recommendations.push(
                    "Need " + capacity.trips + " trips to transport all resources"
                );
                capacity.recommendations.push(
                    "Total time: " + capacity.totalTime + " minutes"
                );
            }
            
            if (capacity.trips > 5) {
                capacity.recommendations.push(
                    "Consider adding more transporters to reduce trips"
                );
            }
            
            return capacity;
        }
        
        /**
         * Calculate storage capacity and overflow risk
         */
        public static function calculateStorage(
            data:Object // {storehouse: {level, count}, resources}
        ):Object {
            var storage:Object = {
                capacity: 0,
                used: 0,
                remaining: {},
                risk: "LOW",
                warnings: []
            };
            
            // Base storage capacity per level
            const BASE_STORAGE:Number = 100000;
            const LEVEL_MULTIPLIER:Number = 2;
            
            // Calculate total capacity
            for (var i:int = 0; i < data.storehouse.level; i++) {
                storage.capacity += BASE_STORAGE * 
                                  Math.pow(LEVEL_MULTIPLIER, i) * 
                                  data.storehouse.count;
            }
            
            // Calculate used storage and remaining
            for (var resource:String in data.resources) {
                storage.used += data.resources[resource];
                storage.remaining[resource] = storage.capacity - 
                                           data.resources[resource];
            }
            
            // Calculate risk and warnings
            var usedPercent:Number = (storage.used / storage.capacity) * 100;
            
            if (usedPercent > 90) {
                storage.risk = "HIGH";
                storage.warnings.push("Storage nearly full");
                storage.warnings.push(
                    "Consider upgrading storehouses or using resources"
                );
            } else if (usedPercent > 75) {
                storage.risk = "MEDIUM";
                storage.warnings.push("Storage over 75% capacity");
            }
            
            return storage;
        }
    }
}
