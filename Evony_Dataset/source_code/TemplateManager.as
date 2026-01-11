package com.evony.useful {
    import flash.net.SharedObject;
    
    public class TemplateManager {
        private static var _instance:TemplateManager;
        private var _templates:Object = {};
        private var _categories:Object = {};
        private var _storage:SharedObject;
        
        // Template categories
        private static const CATEGORIES:Object = {
            BATTLE: "battle",
            RESOURCE: "resource",
            BUILDING: "building",
            RESEARCH: "research",
            TROOP: "troop",
            AUTOMATION: "automation",
            CUSTOM: "custom"
        };
        
        public function TemplateManager() {
            if (_instance) {
                throw new Error("Singleton - use getInstance()");
            }
            initialize();
        }
        
        public static function getInstance():TemplateManager {
            if (!_instance) {
                _instance = new TemplateManager();
            }
            return _instance;
        }
        
        private function initialize():void {
            initializeStorage();
            loadTemplates();
            initializeDefaultTemplates();
        }
        
        /**
         * Save template
         */
        public function saveTemplate(
            name:String,
            category:String,
            content:Object
        ):Object {
            var result:Object = {
                success: false,
                errors: []
            };
            
            try {
                // Validate template
                validateTemplate(content);
                
                // Create template object
                var template:Object = {
                    name: name,
                    category: category,
                    content: content,
                    created: new Date().time,
                    modified: new Date().time,
                    version: 1
                };
                
                // Add metadata
                template.metadata = generateMetadata(template);
                
                // Save template
                _templates[name] = template;
                
                // Update category
                if (!_categories[category]) {
                    _categories[category] = [];
                }
                if (_categories[category].indexOf(name) == -1) {
                    _categories[category].push(name);
                }
                
                // Save to storage
                saveToStorage();
                
                result.success = true;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Load template
         */
        public function loadTemplate(name:String):Object {
            var result:Object = {
                success: false,
                template: null,
                errors: []
            };
            
            try {
                if (!_templates[name]) {
                    throw new Error("Template not found: " + name);
                }
                
                result.template = _templates[name];
                result.success = true;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Update template
         */
        public function updateTemplate(
            name:String,
            updates:Object
        ):Object {
            var result:Object = {
                success: false,
                errors: []
            };
            
            try {
                if (!_templates[name]) {
                    throw new Error("Template not found: " + name);
                }
                
                var template:Object = _templates[name];
                
                // Update fields
                for (var field:String in updates) {
                    if (field != "name" && field != "created") {
                        template[field] = updates[field];
                    }
                }
                
                // Update metadata
                template.modified = new Date().time;
                template.version++;
                template.metadata = generateMetadata(template);
                
                // Save changes
                saveToStorage();
                
                result.success = true;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Delete template
         */
        public function deleteTemplate(name:String):Object {
            var result:Object = {
                success: false,
                errors: []
            };
            
            try {
                if (!_templates[name]) {
                    throw new Error("Template not found: " + name);
                }
                
                var template:Object = _templates[name];
                
                // Remove from category
                var category:String = template.category;
                var index:int = _categories[category].indexOf(name);
                if (index != -1) {
                    _categories[category].splice(index, 1);
                }
                
                // Remove template
                delete _templates[name];
                
                // Save changes
                saveToStorage();
                
                result.success = true;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        /**
         * Get templates by category
         */
        public function getTemplatesByCategory(
            category:String
        ):Array {
            var templates:Array = [];
            
            if (_categories[category]) {
                for each (var name:String in _categories[category]) {
                    if (_templates[name]) {
                        templates.push(_templates[name]);
                    }
                }
            }
            
            return templates;
        }
        
        /**
         * Search templates
         */
        public function searchTemplates(
            query:String,
            options:Object = null
        ):Array {
            var results:Array = [];
            
            for each (var template:Object in _templates) {
                if (matchesSearch(template, query, options)) {
                    results.push(template);
                }
            }
            
            // Sort results
            sortSearchResults(results, options);
            
            return results;
        }
        
        /**
         * Export templates
         */
        public function exportTemplates(
            templates:Array = null
        ):Object {
            var exported:Object = {
                templates: {},
                categories: {},
                metadata: {
                    exported: new Date().time,
                    count: 0
                }
            };
            
            if (!templates) {
                // Export all templates
                exported.templates = _templates;
                exported.categories = _categories;
                exported.metadata.count = Object.keys(_templates).length;
            } else {
                // Export selected templates
                for each (var name:String in templates) {
                    if (_templates[name]) {
                        exported.templates[name] = _templates[name];
                        exported.metadata.count++;
                    }
                }
            }
            
            return exported;
        }
        
        /**
         * Import templates
         */
        public function importTemplates(data:Object):Object {
            var result:Object = {
                success: false,
                imported: 0,
                errors: []
            };
            
            try {
                // Validate import data
                if (!data.templates) {
                    throw new Error("Invalid import data");
                }
                
                // Import templates
                for (var name:String in data.templates) {
                    try {
                        var template:Object = data.templates[name];
                        saveTemplate(
                            name,
                            template.category,
                            template.content
                        );
                        result.imported++;
                    } catch (e:Error) {
                        result.errors.push(
                            "Failed to import " + name + ": " + e.message
                        );
                    }
                }
                
                result.success = true;
                
            } catch (e:Error) {
                result.errors.push(e.message);
            }
            
            return result;
        }
        
        // Helper functions
        private function initializeStorage():void {
            try {
                _storage = SharedObject.getLocal("templateManager");
            } catch (e:Error) {
                trace("Error initializing storage: " + e.message);
            }
        }
        
        private function loadTemplates():void {
            try {
                if (_storage && _storage.data.templates) {
                    _templates = _storage.data.templates;
                }
                if (_storage && _storage.data.categories) {
                    _categories = _storage.data.categories;
                }
            } catch (e:Error) {
                trace("Error loading templates: " + e.message);
            }
        }
        
        private function saveToStorage():void {
            try {
                if (_storage) {
                    _storage.data.templates = _templates;
                    _storage.data.categories = _categories;
                    _storage.flush();
                }
            } catch (e:Error) {
                trace("Error saving templates: " + e.message);
            }
        }
        
        private function validateTemplate(content:Object):void {
            if (!content) {
                throw new Error("Empty template content");
            }
            
            // Add more validation as needed
        }
        
        private function generateMetadata(template:Object):Object {
            return {
                size: JSON.stringify(template.content).length,
                complexity: calculateComplexity(template.content),
                dependencies: findDependencies(template.content),
                hash: generateHash(template.content)
            };
        }
        
        private function calculateComplexity(content:Object):Number {
            // Calculate template complexity score
            return 1;
        }
        
        private function findDependencies(content:Object):Array {
            // Find template dependencies
            return [];
        }
        
        private function generateHash(content:Object):String {
            // Generate content hash
            return "hash";
        }
        
        private function matchesSearch(
            template:Object,
            query:String,
            options:Object
        ):Boolean {
            query = query.toLowerCase();
            
            // Check name
            if (template.name.toLowerCase().indexOf(query) != -1) {
                return true;
            }
            
            // Check category
            if (template.category.toLowerCase().indexOf(query) != -1) {
                return true;
            }
            
            // Check content
            if (JSON.stringify(template.content).toLowerCase().indexOf(query) != -1) {
                return true;
            }
            
            return false;
        }
        
        private function sortSearchResults(
            results:Array,
            options:Object
        ):void {
            if (!options || !options.sortBy) {
                // Default sort by modified date
                results.sort(function(a:Object, b:Object):Number {
                    return b.modified - a.modified;
                });
                return;
            }
            
            switch (options.sortBy) {
                case "name":
                    results.sort(function(a:Object, b:Object):Number {
                        return a.name.localeCompare(b.name);
                    });
                    break;
                    
                case "category":
                    results.sort(function(a:Object, b:Object):Number {
                        return a.category.localeCompare(b.category);
                    });
                    break;
                    
                case "created":
                    results.sort(function(a:Object, b:Object):Number {
                        return b.created - a.created;
                    });
                    break;
                    
                case "complexity":
                    results.sort(function(a:Object, b:Object):Number {
                        return b.metadata.complexity - a.metadata.complexity;
                    });
                    break;
            }
        }
        
        private function initializeDefaultTemplates():void {
            // Add default templates if none exist
            if (Object.keys(_templates).length == 0) {
                // Add default templates here
            }
        }
    }
}
