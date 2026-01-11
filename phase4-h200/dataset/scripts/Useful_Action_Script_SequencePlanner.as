package com.evony.useful {
    public class SequencePlanner {
        // Constants
        private static const MAX_32BIT:Number = 2147483647;
        private static const SAFE_LIMIT:Number = 700000000;
        private static const MIN_WAIT_TIME:Number = 5; // minutes
        
        /**
         * Plan a sequence of operations
         * @param operations Array of operations to plan
         * @param constraints Object containing timing and safety constraints
         */
        public function planSequence(
            operations:Array,
            constraints:Object
        ):Object {
            var plan:Object = {
                sequence: [],
                totalTime: 0,
                safe: true,
                warnings: [],
                recommendations: []
            };
            
            // Sort operations by priority and dependencies
            var sortedOps:Array = sortOperations(operations);
            
            // Calculate timings
            var currentTime:Number = 0;
            var lastOpType:String = "";
            
            for each (var op:Object in sortedOps) {
                var timing:Object = calculateTiming(
                    op,
                    lastOpType,
                    currentTime,
                    constraints
                );
                
                // Add operation to sequence
                plan.sequence.push({
                    operation: op.type,
                    troops: op.troops,
                    startTime: timing.startTime,
                    duration: timing.duration,
                    waitAfter: timing.waitTime
                });
                
                // Update tracking
                currentTime = timing.startTime + timing.duration + timing.waitTime;
                lastOpType = op.type;
                
                // Add any warnings
                if (timing.warnings.length > 0) {
                    plan.warnings = plan.warnings.concat(timing.warnings);
                }
            }
            
            plan.totalTime = currentTime;
            
            // Add safety recommendations
            if (plan.warnings.length > 0) {
                plan.recommendations.push(
                    "Consider splitting operations into smaller batches"
                );
                plan.recommendations.push(
                    "Add additional wait time between critical operations"
                );
            }
            
            return plan;
        }
        
        /**
         * Sort operations by priority and dependencies
         */
        private function sortOperations(operations:Array):Array {
            // Priority order
            var priorityOrder:Object = {
                "recovery": 1,
                "safety": 2,
                "valley": 3,
                "thunder": 4,
                "normal": 5
            };
            
            return operations.sort(function(a:Object, b:Object):Number {
                // Sort by priority first
                var priorityDiff:Number = 
                    priorityOrder[a.priority] - priorityOrder[b.priority];
                
                if (priorityDiff != 0) return priorityDiff;
                
                // Then by dependencies
                if (hasDependency(b, a)) return -1;
                if (hasDependency(a, b)) return 1;
                
                return 0;
            });
        }
        
        /**
         * Check if operation a depends on operation b
         */
        private function hasDependency(a:Object, b:Object):Boolean {
            if (!a.dependencies) return false;
            return a.dependencies.indexOf(b.id) != -1;
        }
        
        /**
         * Calculate timing for an operation
         */
        private function calculateTiming(
            operation:Object,
            lastOpType:String,
            currentTime:Number,
            constraints:Object
        ):Object {
            var timing:Object = {
                startTime: currentTime,
                duration: 0,
                waitTime: MIN_WAIT_TIME,
                warnings: []
            };
            
            // Base duration by operation type
            switch (operation.type) {
                case "thunder":
                    timing.duration = 15;
                    timing.waitTime = 10;
                    break;
                case "valley":
                    timing.duration = 10;
                    timing.waitTime = 8;
                    break;
                case "recovery":
                    timing.duration = 5;
                    timing.waitTime = 15;
                    break;
                default:
                    timing.duration = 5;
            }
            
            // Adjust timing based on troop count
            if (operation.troops > SAFE_LIMIT) {
                timing.waitTime += 5;
                timing.warnings.push(
                    "Large troop movement - increased wait time"
                );
            }
            
            // Adjust for consecutive operations of same type
            if (operation.type == lastOpType) {
                timing.waitTime += 5;
                timing.warnings.push(
                    "Consecutive " + operation.type + 
                    " operations - added safety buffer"
                );
            }
            
            // Apply constraints
            if (constraints) {
                if (constraints.maxDuration && 
                    timing.duration > constraints.maxDuration) {
                    timing.warnings.push(
                        "Operation exceeds maximum duration"
                    );
                }
                
                if (constraints.minWaitTime && 
                    timing.waitTime < constraints.minWaitTime) {
                    timing.waitTime = constraints.minWaitTime;
                }
            }
            
            return timing;
        }
        
        /**
         * Create a recovery sequence plan
         */
        public function planRecoverySequence(
            negativeAmount:Number,
            constraints:Object = null
        ):Object {
            var recoveryPlan:Object = {
                operations: [],
                totalTime: 0,
                safe: true,
                warnings: [],
                recommendations: []
            };
            
            var remaining:Number = Math.abs(negativeAmount);
            var opCount:int = 1;
            
            while (remaining > 0) {
                var amount:Number = Math.min(remaining, SAFE_LIMIT);
                
                recoveryPlan.operations.push({
                    step: opCount++,
                    amount: amount,
                    waitTime: 15 // Higher wait time for recovery
                });
                
                remaining -= amount;
            }
            
            // Calculate total time
            recoveryPlan.totalTime = 
                recoveryPlan.operations.length * 15; // 15 minutes per operation
            
            // Add recommendations
            if (recoveryPlan.operations.length > 1) {
                recoveryPlan.recommendations.push(
                    "Split recovery into " + 
                    recoveryPlan.operations.length + 
                    " operations"
                );
                recoveryPlan.recommendations.push(
                    "Total recovery time: " + 
                    recoveryPlan.totalTime + 
                    " minutes"
                );
            }
            
            return recoveryPlan;
        }
        
        /**
         * Create a valley chain sequence plan
         */
        public function planValleyChain(
            valleyCount:Number,
            troopsPerValley:Number,
            constraints:Object = null
        ):Object {
            var chainPlan:Object = {
                operations: [],
                totalTime: 0,
                safe: true,
                warnings: [],
                recommendations: []
            };
            
            // Check troop safety
            if (troopsPerValley > SAFE_LIMIT) {
                chainPlan.safe = false;
                chainPlan.warnings.push(
                    "Troops per valley exceed safe limit"
                );
            }
            
            // Create operation sequence
            for (var i:int = 0; i < valleyCount; i++) {
                chainPlan.operations.push({
                    step: i + 1,
                    amount: troopsPerValley,
                    waitTime: 10,
                    valley: "Valley " + (i + 1)
                });
            }
            
            // Calculate total time
            chainPlan.totalTime = chainPlan.operations.length * 10;
            
            // Add recommendations for large operations
            if (!chainPlan.safe) {
                chainPlan.recommendations.push(
                    "Consider splitting troops into smaller amounts"
                );
                chainPlan.recommendations.push(
                    "Add extra wait time between operations"
                );
            }
            
            return chainPlan;
        }
    }
}
