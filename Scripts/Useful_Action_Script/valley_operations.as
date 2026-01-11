package com.evony.useful {
    public class ValleyOperations {
        // Constants
        private static const MAX_32BIT:Number = 2147483647;
        private static const SAFE_LIMIT:Number = 700000000;
        private static const VALLEY_LIMIT:Number = 1800000000;
        private static const MULTIPLY_FACTOR:Number = 3;
        
        /**
         * Thunder raid calculator
         * Calculates optimal troop amounts for valley operations
         */
        public static function calculateThunderRaid(
            currentTroops:Number,
            valleyDistance:Number
        ):Object {
            var raid:Object = {
                safe: true,
                optimal: true,
                troopCount: currentTroops,
                multipliedAmount: 0,
                warnings: [],
                recommendations: []
            };
            
            // Calculate multiplication effect
            raid.multipliedAmount = currentTroops * MULTIPLY_FACTOR;
            
            // Check for optimal conditions
            if (valleyDistance > 1) {
                raid.optimal = false;
                raid.recommendations.push("Use closest valley for optimal results");
            }
            
            // Check troop amounts
            if (currentTroops > SAFE_LIMIT) {
                raid.safe = false;
                raid.warnings.push("Exceeds safe limit of " + SAFE_LIMIT);
                
                if (currentTroops > VALLEY_LIMIT) {
                    raid.warnings.push("CRITICAL: Exceeds valley limit");
                    raid.recommendations.push(
                        "Reduce troops to below " + VALLEY_LIMIT
                    );
                }
            }
            
            // Calculate overflow risk
            if (raid.multipliedAmount > MAX_32BIT) {
                raid.warnings.push(
                    "WARNING: Will overflow after multiplication"
                );
                
                // Calculate safe amount
                var safeAmount:Number = Math.floor(MAX_32BIT / MULTIPLY_FACTOR);
                raid.recommendations.push(
                    "Use " + safeAmount + " troops to prevent overflow"
                );
            }
            
            return raid;
        }
        
        /**
         * Valley chain calculator
         * For multiple valley operations
         */
        public static function calculateValleyChain(
            troopCount:Number,
            valleyCount:Number
        ):Object {
            var chain:Object = {
                operations: [],
                totalTime: 0,
                safe: true,
                warnings: []
            };
            
            // Calculate troops per valley
            var troopsPerValley:Number = Math.floor(troopCount / valleyCount);
            
            // Check safety
            if (troopsPerValley > SAFE_LIMIT) {
                chain.safe = false;
                chain.warnings.push("Troops per valley exceed safe limit");
                
                // Calculate safe distribution
                var safeValleys:Number = Math.ceil(troopCount / SAFE_LIMIT);
                chain.warnings.push(
                    "Need " + safeValleys + " valleys for safe operation"
                );
            }
            
            // Generate operations
            for (var i:int = 0; i < valleyCount; i++) {
                chain.operations.push({
                    index: i + 1,
                    troops: troopsPerValley,
                    timing: i * 5 // 5 minute spacing
                });
            }
            
            chain.totalTime = (valleyCount - 1) * 5;
            
            return chain;
        }
        
        /**
         * Recovery calculator for valley operations
         */
        public static function calculateValleyRecovery(
            currentTroops:Number,
            isNegative:Boolean
        ):Object {
            var recovery:Object = {
                needed: 0,
                operations: [],
                totalTime: 0,
                recommendations: []
            };
            
            if (isNegative) {
                recovery.needed = Math.abs(currentTroops);
                
                // Calculate recovery operations
                var remaining:Number = recovery.needed;
                var opIndex:int = 1;
                
                while (remaining > 0) {
                    var amount:Number = Math.min(remaining, SAFE_LIMIT);
                    recovery.operations.push({
                        step: opIndex++,
                        amount: amount,
                        waitTime: 10 // 10 minute cooldown
                    });
                    remaining -= amount;
                }
                
                recovery.totalTime = recovery.operations.length * 10;
                
                recovery.recommendations.push(
                    "Total recovery needs " + recovery.operations.length + 
                    " operations"
                );
                recovery.recommendations.push(
                    "Total time needed: " + recovery.totalTime + " minutes"
                );
            }
            
            return recovery;
        }
        
        /**
         * Calculate optimal valley selection
         */
        public static function calculateOptimalValley(
            valleys:Array, // Array of {distance, level} objects
            troopCount:Number
        ):Object {
            var optimal:Object = {
                selected: null,
                safe: true,
                warnings: [],
                alternatives: []
            };
            
            // Sort valleys by distance
            valleys.sort(function(a:Object, b:Object):Number {
                return a.distance - b.distance;
            });
            
            // Find closest suitable valley
            for each (var valley:Object in valleys) {
                if (optimal.selected == null) {
                    optimal.selected = valley;
                } else {
                    optimal.alternatives.push(valley);
                }
            }
            
            // Check troop safety
            if (troopCount > SAFE_LIMIT) {
                optimal.safe = false;
                optimal.warnings.push(
                    "Troop count exceeds safe limit for valley operations"
                );
            }
            
            return optimal;
        }
    }
}
