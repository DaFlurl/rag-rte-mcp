package com.evony.useful {
    public class NLPProcessor {
        private static var _instance:NLPProcessor;
        private var _vocabulary:Object = {};
        private var _patterns:Array = [];
        private var _contextHistory:Array = [];
        
        // Intent categories
        private static const INTENTS:Object = {
            BATTLE: ["attack", "defend", "scout", "reinforce"],
            RESOURCE: ["gather", "transport", "produce", "upgrade"],
            BUILD: ["construct", "upgrade", "demolish", "repair"],
            TRAIN: ["train", "research", "heal", "dismiss"],
            MANAGE: ["set", "check", "monitor", "automate"]
        };
        
        // Entity types
        private static const ENTITIES:Object = {
            CITY: ["city", "town", "base", "location"],
            RESOURCE: ["food", "wood", "stone", "iron", "gold"],
            TROOP: ["warrior", "archer", "cavalry", "siege"],
            BUILDING: ["cottage", "barracks", "wall", "workshop"],
            TIME: ["now", "later", "daily", "hourly"]
        };
        
        public function NLPProcessor() {
            if (_instance) {
                throw new Error("Singleton - use getInstance()");
            }
            initialize();
        }
        
        public static function getInstance():NLPProcessor {
            if (!_instance) {
                _instance = new NLPProcessor();
            }
            return _instance;
        }
        
        /**
         * Process natural language command
         */
        public function processCommand(
            command:String,
            context:Object = null
        ):Object {
            var result:Object = {
                success: false,
                intent: null,
                entities: [],
                confidence: 0,
                errors: []
            };
            
            try {
                // Preprocess command
                var processed:String = preprocessCommand(command);
                
                // Extract intent
                var intent:Object = extractIntent(processed);
                
                // Extract entities
                var entities:Array = extractEntities(processed);
                
                // Apply context
                if (context) {
                    applyContext(intent, entities, context);
                }
                
                // Calculate confidence
                var confidence:Number = calculateConfidence(
                    intent,
                    entities
                );
                
                // Update result
                result.success = true;
                result.intent = intent;
                result.entities = entities;
                result.confidence = confidence;
                
                // Update context history
                updateContextHistory(result);
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Get command suggestions
         */
        public function getSuggestions(
            partial:String,
            context:Object = null
        ):Array {
            var suggestions:Array = [];
            
            try {
                // Process partial command
                var processed:Object = processCommand(partial, context);
                
                // Find matching patterns
                var matches:Array = findMatchingPatterns(processed);
                
                // Generate suggestions
                for each (var match:Object in matches) {
                    suggestions.push(
                        generateSuggestion(match, context)
                    );
                }
                
                // Sort by relevance
                suggestions.sort(function(a:Object, b:Object):Number {
                    return b.relevance - a.relevance;
                });
                
            } catch (e:Error) {
                trace("Error generating suggestions: " + e.message);
            }
            
            return suggestions;
        }
        
        /**
         * Learn from user interaction
         */
        public function learn(
            command:String,
            resolution:Object
        ):void {
            try {
                // Extract learning patterns
                var patterns:Array = extractPatterns(
                    command,
                    resolution
                );
                
                // Update vocabulary
                updateVocabulary(patterns);
                
                // Update pattern matching
                updatePatterns(patterns);
                
            } catch (e:Error) {
                trace("Error learning from interaction: " + e.message);
            }
        }
        
        // Helper functions
        private function initialize():void {
            loadVocabulary();
            loadPatterns();
        }
        
        private function preprocessCommand(command:String):String {
            // Normalize text
            command = command.toLowerCase();
            
            // Remove special characters
            command = command.replace(/[^\w\s]/g, " ");
            
            // Remove extra spaces
            command = command.replace(/\s+/g, " ").trim();
            
            return command;
        }
        
        private function extractIntent(command:String):Object {
            var intent:Object = {
                category: "",
                action: "",
                parameters: {},
                confidence: 0
            };
            
            // Match intent patterns
            for (var category:String in INTENTS) {
                var actions:Array = INTENTS[category];
                for each (var action:String in actions) {
                    if (command.indexOf(action) !== -1) {
                        intent.category = category;
                        intent.action = action;
                        intent.confidence = 0.8;
                        break;
                    }
                }
                if (intent.category) break;
            }
            
            return intent;
        }
        
        private function extractEntities(command:String):Array {
            var entities:Array = [];
            
            // Match entity patterns
            for (var type:String in ENTITIES) {
                var keywords:Array = ENTITIES[type];
                for each (var keyword:String in keywords) {
                    if (command.indexOf(keyword) !== -1) {
                        entities.push({
                            type: type,
                            value: keyword,
                            confidence: 0.8
                        });
                    }
                }
            }
            
            return entities;
        }
        
        private function applyContext(
            intent:Object,
            entities:Array,
            context:Object
        ):void {
            // Apply context to intent
            if (context.lastIntent && !intent.category) {
                intent.category = context.lastIntent.category;
                intent.confidence *= 0.8;
            }
            
            // Apply context to entities
            if (context.lastEntities) {
                for each (var contextEntity:Object in context.lastEntities) {
                    var found:Boolean = false;
                    for each (var entity:Object in entities) {
                        if (entity.type == contextEntity.type) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        entities.push({
                            type: contextEntity.type,
                            value: contextEntity.value,
                            confidence: contextEntity.confidence * 0.8
                        });
                    }
                }
            }
        }
        
        private function calculateConfidence(
            intent:Object,
            entities:Array
        ):Number {
            var confidence:Number = intent.confidence;
            
            // Adjust based on entities
            if (entities.length > 0) {
                var entityConfidence:Number = 0;
                for each (var entity:Object in entities) {
                    entityConfidence += entity.confidence;
                }
                entityConfidence /= entities.length;
                confidence = (confidence + entityConfidence) / 2;
            }
            
            return confidence;
        }
        
        private function updateContextHistory(result:Object):void {
            _contextHistory.push({
                timestamp: new Date().time,
                result: result
            });
            
            // Keep history manageable
            if (_contextHistory.length > 100) {
                _contextHistory.shift();
            }
        }
        
        private function findMatchingPatterns(processed:Object):Array {
            var matches:Array = [];
            
            for each (var pattern:Object in _patterns) {
                var score:Number = calculatePatternMatch(
                    pattern,
                    processed
                );
                if (score > 0.5) {
                    matches.push({
                        pattern: pattern,
                        score: score
                    });
                }
            }
            
            return matches;
        }
        
        private function generateSuggestion(
            match:Object,
            context:Object
        ):Object {
            return {
                text: generateSuggestionText(match.pattern),
                relevance: match.score,
                context: context
            };
        }
        
        private function extractPatterns(
            command:String,
            resolution:Object
        ):Array {
            var patterns:Array = [];
            
            // Extract command patterns
            var words:Array = command.split(" ");
            for (var i:int = 0; i < words.length; i++) {
                for (var j:int = i + 1; j <= words.length; j++) {
                    patterns.push({
                        text: words.slice(i, j).join(" "),
                        resolution: resolution
                    });
                }
            }
            
            return patterns;
        }
        
        private function updateVocabulary(patterns:Array):void {
            for each (var pattern:Object in patterns) {
                var words:Array = pattern.text.split(" ");
                for each (var word:String in words) {
                    if (!_vocabulary[word]) {
                        _vocabulary[word] = {
                            count: 0,
                            patterns: []
                        };
                    }
                    _vocabulary[word].count++;
                    _vocabulary[word].patterns.push(pattern);
                }
            }
        }
        
        private function updatePatterns(patterns:Array):void {
            for each (var pattern:Object in patterns) {
                var exists:Boolean = false;
                for each (var existing:Object in _patterns) {
                    if (existing.text == pattern.text) {
                        exists = true;
                        break;
                    }
                }
                if (!exists) {
                    _patterns.push(pattern);
                }
            }
        }
        
        private function loadVocabulary():void {
            // Load vocabulary data
            // Implementation needed
        }
        
        private function loadPatterns():void {
            // Load pattern data
            // Implementation needed
        }
        
        private function calculatePatternMatch(
            pattern:Object,
            processed:Object
        ):Number {
            // Calculate pattern match score
            return 0;
        }
        
        private function generateSuggestionText(pattern:Object):String {
            // Generate suggestion text
            return "";
        }
    }
}
