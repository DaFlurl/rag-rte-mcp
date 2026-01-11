package com.evony.useful {
    public class CityFilterSystem {
        // Filter types
        private static const FILTER_TYPES:Object = {
            LEVEL: "level",
            RESOURCES: "resources",
            TROOPS: "troops",
            BUILDINGS: "buildings",
            RESEARCH: "research",
            LOCATION: "location",
            STATUS: "status",
            CUSTOM: "custom"
        };
        
        // Predefined filters
        private static var _predefinedFilters:Object = {
            // Level-based filters
            highLevel: {
                type: FILTER_TYPES.LEVEL,
                condition: "city.level >= 9"
            },
            lowLevel: {
                type: FILTER_TYPES.LEVEL,
                condition: "city.level <= 5"
            },
            
            // Resource-based filters
            resourceRich: {
                type: FILTER_TYPES.RESOURCES,
                condition: "city.resources.total >= 1000000"
            },
            foodShortage: {
                type: FILTER_TYPES.RESOURCES,
                condition: "city.resources.food <= 100000"
            },
            
            // Troop-based filters
            strongArmy: {
                type: FILTER_TYPES.TROOPS,
                condition: "city.troops.total >= 500000"
            },
            needsDefense: {
                type: FILTER_TYPES.TROOPS,
                condition: "city.troops.defense <= 100000"
            },
            
            // Building-based filters
            hasWorkshop: {
                type: FILTER_TYPES.BUILDINGS,
                condition: "city.buildings.workshop.level >= 1"
            },
            maxWalls: {
                type: FILTER_TYPES.BUILDINGS,
                condition: "city.buildings.wall.level >= 10"
            },
            
            // Research-based filters
            militaryFocus: {
                type: FILTER_TYPES.RESEARCH,
                condition: "city.research.military.level >= 9"
            },
            economyFocus: {
                type: FILTER_TYPES.RESEARCH,
                condition: "city.research.economy.level >= 9"
            },
            
            // Location-based filters
            borderCities: {
                type: FILTER_TYPES.LOCATION,
                condition: "city.location.isBorder"
            },
            centralCities: {
                type: FILTER_TYPES.LOCATION,
                condition: "city.location.isCenter"
            },
            
            // Status-based filters
            underAttack: {
                type: FILTER_TYPES.STATUS,
                condition: "city.status.isUnderAttack"
            },
            peaceful: {
                type: FILTER_TYPES.STATUS,
                condition: "!city.status.isAtWar"
            }
        };
        
        // Custom filters storage
        private static var _customFilters:Object = {};
        
        /**
         * Filter cities based on conditions
         */
        public static function filterCities(
            cities:Array,
            filters:Array
        ):Array {
            var filteredCities:Array = [];
            
            for each (var city:Object in cities) {
                if (matchesAllFilters(city, filters)) {
                    filteredCities.push(city);
                }
            }
            
            return filteredCities;
        }
        
        /**
         * Create custom filter
         */
        public static function createCustomFilter(
            name:String,
            type:String,
            condition:String,
            description:String = ""
        ):void {
            _customFilters[name] = {
                type: type,
                condition: condition,
                description: description,
                created: new Date().time
            };
        }
        
        /**
         * Get available filters
         */
        public static function getAvailableFilters():Object {
            return {
                predefined: _predefinedFilters,
                custom: _customFilters
            };
        }
        
        /**
         * Create complex filter
         */
        public static function createComplexFilter(
            conditions:Array
        ):Function {
            return function(city:Object):Boolean {
                return evaluateComplexConditions(city, conditions);
            };
        }
        
        /**
         * Smart city selection
         */
        public static function smartSelect(
            cities:Array,
            criteria:Object
        ):Array {
            var selected:Array = [];
            var scores:Object = {};
            
            // Score each city
            for each (var city:Object in cities) {
                scores[city.id] = calculateCityScore(city, criteria);
            }
            
            // Sort cities by score
            cities.sort(function(a:Object, b:Object):Number {
                return scores[b.id] - scores[a.id];
            });
            
            // Select top cities
            var count:int = criteria.count || cities.length;
            selected = cities.slice(0, count);
            
            return selected;
        }
        
        // Helper functions
        private static function matchesAllFilters(
            city:Object,
            filters:Array
        ):Boolean {
            for each (var filter:Object in filters) {
                if (!evaluateFilter(city, filter)) {
                    return false;
                }
            }
            return true;
        }
        
        private static function evaluateFilter(
            city:Object,
            filter:Object
        ):Boolean {
            // Get filter definition
            var filterDef:Object = _predefinedFilters[filter.name] || 
                                 _customFilters[filter.name];
            
            if (!filterDef) {
                return false;
            }
            
            // Evaluate condition based on type
            switch (filterDef.type) {
                case FILTER_TYPES.LEVEL:
                    return evaluateLevelCondition(city, filterDef.condition);
                    
                case FILTER_TYPES.RESOURCES:
                    return evaluateResourceCondition(city, filterDef.condition);
                    
                case FILTER_TYPES.TROOPS:
                    return evaluateTroopCondition(city, filterDef.condition);
                    
                case FILTER_TYPES.BUILDINGS:
                    return evaluateBuildingCondition(city, filterDef.condition);
                    
                case FILTER_TYPES.RESEARCH:
                    return evaluateResearchCondition(city, filterDef.condition);
                    
                case FILTER_TYPES.LOCATION:
                    return evaluateLocationCondition(city, filterDef.condition);
                    
                case FILTER_TYPES.STATUS:
                    return evaluateStatusCondition(city, filterDef.condition);
                    
                case FILTER_TYPES.CUSTOM:
                    return evaluateCustomCondition(city, filterDef.condition);
            }
            
            return false;
        }
        
        private static function evaluateComplexConditions(
            city:Object,
            conditions:Array
        ):Boolean {
            for each (var condition:Object in conditions) {
                if (!evaluateFilter(city, condition)) {
                    return false;
                }
            }
            return true;
        }
        
        private static function calculateCityScore(
            city:Object,
            criteria:Object
        ):Number {
            var score:Number = 0;
            
            // Weight different factors
            if (criteria.resources) {
                score += calculateResourceScore(city) * criteria.resources;
            }
            
            if (criteria.troops) {
                score += calculateTroopScore(city) * criteria.troops;
            }
            
            if (criteria.buildings) {
                score += calculateBuildingScore(city) * criteria.buildings;
            }
            
            if (criteria.research) {
                score += calculateResearchScore(city) * criteria.research;
            }
            
            if (criteria.location) {
                score += calculateLocationScore(city) * criteria.location;
            }
            
            return score;
        }
        
        // Condition evaluators
        private static function evaluateLevelCondition(
            city:Object,
            condition:String
        ):Boolean {
            return evaluateNumericCondition(city.level, condition);
        }
        
        private static function evaluateResourceCondition(
            city:Object,
            condition:String
        ):Boolean {
            return evaluateNumericCondition(
                city.resources.total,
                condition
            );
        }
        
        private static function evaluateTroopCondition(
            city:Object,
            condition:String
        ):Boolean {
            return evaluateNumericCondition(
                city.troops.total,
                condition
            );
        }
        
        private static function evaluateBuildingCondition(
            city:Object,
            condition:String
        ):Boolean {
            var parts:Array = condition.split(".");
            if (parts.length >= 3) {
                var building:String = parts[1];
                var level:int = int(parts[2]);
                return city.buildings[building].level >= level;
            }
            return false;
        }
        
        private static function evaluateResearchCondition(
            city:Object,
            condition:String
        ):Boolean {
            var parts:Array = condition.split(".");
            if (parts.length >= 3) {
                var type:String = parts[1];
                var level:int = int(parts[2]);
                return city.research[type].level >= level;
            }
            return false;
        }
        
        private static function evaluateLocationCondition(
            city:Object,
            condition:String
        ):Boolean {
            return Boolean(city.location[condition]);
        }
        
        private static function evaluateStatusCondition(
            city:Object,
            condition:String
        ):Boolean {
            return Boolean(city.status[condition]);
        }
        
        private static function evaluateCustomCondition(
            city:Object,
            condition:String
        ):Boolean {
            try {
                return Boolean(condition);
            } catch (e:Error) {
                return false;
            }
        }
        
        private static function evaluateNumericCondition(
            value:Number,
            condition:String
        ):Boolean {
            try {
                return Boolean(condition);
            } catch (e:Error) {
                return false;
            }
        }
        
        // Scoring functions
        private static function calculateResourceScore(city:Object):Number {
            var score:Number = 0;
            
            // Resource scores
            score += city.resources.food / 1000000;
            score += city.resources.wood / 1000000;
            score += city.resources.stone / 1000000;
            score += city.resources.iron / 1000000;
            score += city.resources.gold / 100000;
            
            return score;
        }
        
        private static function calculateTroopScore(city:Object):Number {
            var score:Number = 0;
            
            // Troop scores
            score += city.troops.warrior * 1;
            score += city.troops.pike * 1;
            score += city.troops.sword * 1.2;
            score += city.troops.archer * 1.5;
            score += city.troops.cavalry * 2;
            score += city.troops.cataphract * 3;
            
            return score / 100000;
        }
        
        private static function calculateBuildingScore(city:Object):Number {
            var score:Number = 0;
            
            // Building scores
            for (var building:String in city.buildings) {
                score += city.buildings[building].level;
            }
            
            return score / 10;
        }
        
        private static function calculateResearchScore(city:Object):Number {
            var score:Number = 0;
            
            // Research scores
            for (var type:String in city.research) {
                score += city.research[type].level;
            }
            
            return score;
        }
        
        private static function calculateLocationScore(city:Object):Number {
            var score:Number = 0;
            
            // Location scores
            if (city.location.isBorder) score += 5;
            if (city.location.isCenter) score += 3;
            if (city.location.isProtected) score += 2;
            
            return score;
        }
    }
}
