package com.evony.useful {
    public class TroopOperations {
        // Constants for safe operations
        private static const MAX_32BIT:Number = 2147483647;  // 2.147B
        private static const SAFE_LIMIT:Number = 700000000;  // 700M
        private static const VALLEY_LIMIT:Number = 1800000000; // 1.8B
        private static const MULTIPLY_FACTOR:Number = 3;
        
        /**
         * Calculate safe troop split for large operations
         */
        public static function calculateSafeSplit(troopCount:Number):Array {
            var splits:Array = [];
            var remaining:Number = troopCount;
            
            while (remaining > 0) {
                var currentBatch:Number = Math.min(remaining, SAFE_LIMIT);
                splits.push(currentBatch);
                remaining -= currentBatch;
            }
            
            return splits;
        }
        
        /**
         * Calculate valley operation parameters
         */
        public static function calculateValleyOperation(
            troopCount:Number,
            distance:Number
        ):Object {
            var result:Object = {
                safe: true,
                splits: [],
                warnings: [],
                multipliedAmount: troopCount * MULTIPLY_FACTOR
            };
            
            // Check for multiplication overflow
            if (result.multipliedAmount > MAX_32BIT) {
                result.safe = false;
                result.warnings.push("WARNING: Will overflow after multiplication");
            }
            
            // Check distance
            if (distance > 1) {
                result.warnings.push("Not using closest valley - increased risk");
            }
            
            // Calculate splits if needed
            if (troopCount > SAFE_LIMIT) {
                result.splits = calculateSafeSplit(troopCount);
                result.warnings.push(
                    "Large troop movement - split into " + 
                    result.splits.length + " operations"
                );
            }
            
            return result;
        }
        
        /**
         * Calculate recovery from negative troops
         */
        public static function calculateRecovery(
            negativeAmount:Number
        ):Object {
            var needed:Number = Math.abs(negativeAmount);
            var recovery:Object = {
                splits: [],
                totalTime: 0,
                recommendations: []
            };
            
            // Calculate recovery batches
            recovery.splits = calculateSafeSplit(needed);
            recovery.totalTime = recovery.splits.length * 10; // 10 minutes between splits
            
            // Add recommendations
            recovery.recommendations.push(
                "Need " + recovery.splits.length + " transfers of " +
                SAFE_LIMIT + " troops each"
            );
            recovery.recommendations.push(
                "Total time needed: " + recovery.totalTime + " minutes"
            );
            
            return recovery;
        }
        
        /**
         * Calculate food consumption for troop counts
         */
        public static function calculateFoodConsumption(
            troops:Object
        ):Object {
            var consumption:Object = {
                hourly: 0,
                daily: 0,
                weekly: 0,
                safe: true,
                warnings: []
            };
            
            // Food consumption rates per troop
            var rates:Object = {
                worker: 1,
                warrior: 2,
                scout: 2,
                pike: 2,
                sword: 3,
                archer: 3,
                trans: 4,
                ballista: 5,
                cat: 6,
                cavalry: 4
            };
            
            // Calculate total consumption
            for (var type:String in troops) {
                if (rates.hasOwnProperty(type)) {
                    var amount:Number = troops[type] * rates[type];
                    consumption.hourly += amount;
                }
            }
            
            // Calculate time-based consumption
            consumption.daily = consumption.hourly * 24;
            consumption.weekly = consumption.daily * 7;
            
            // Check for overflow
            if (consumption.daily > MAX_32BIT) {
                consumption.safe = false;
                consumption.warnings.push(
                    "Daily food consumption will overflow"
                );
            }
            
            return consumption;
        }
        
        /**
         * Calculate safe troop distribution across cities
         */
        public static function calculateCityDistribution(
            totalTroops:Number,
            cityCount:Number
        ):Object {
            var distribution:Object = {
                perCity: 0,
                safe: true,
                warnings: [],
                recommendations: []
            };
            
            // Calculate troops per city
            distribution.perCity = Math.floor(totalTroops / cityCount);
            
            // Check safety
            if (distribution.perCity > SAFE_LIMIT) {
                distribution.safe = false;
                distribution.warnings.push(
                    "Troops per city exceed safe limit"
                );
                
                // Calculate safe distribution
                var safeCities:Number = Math.ceil(totalTroops / SAFE_LIMIT);
                distribution.recommendations.push(
                    "Need " + safeCities + " cities for safe distribution"
                );
            }
            
            return distribution;
        }
    }
}
