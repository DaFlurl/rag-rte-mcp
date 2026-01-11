package com.evony.useful {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class AdvancedScriptWindow extends Sprite {
        // UI Components
        private var _scriptTabs:TabBar;
        private var _citySelector:CitySelector;
        private var _scriptEditor:ScriptEditor;
        private var _validationDisplay:ValidationDisplay;
        private var _statusBar:StatusBar;
        
        // Script Management
        private var _activeScripts:Object = {};
        private var _scriptHistory:Array = [];
        private var _validator:ScriptValidator;
        
        // Window States
        private var _isGoalWindow:Boolean;
        private var _isMinimized:Boolean;
        
        public function AdvancedScriptWindow(isGoalWindow:Boolean = false) {
            _isGoalWindow = isGoalWindow;
            _validator = new ScriptValidator();
            
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void {
            if (e) removeEventListener(Event.ADDED_TO_STAGE, init);
            createUI();
            loadSavedScripts();
        }
        
        private function createUI():void {
            // Create main container
            graphics.beginFill(0x333333);
            graphics.drawRect(0, 0, 800, 600);
            graphics.endFill();
            
            // Create script tabs
            _scriptTabs = new TabBar([
                "Active Scripts",
                "Script Editor",
                "History",
                "Templates"
            ]);
            _scriptTabs.y = 10;
            _scriptTabs.addEventListener("tabChanged", onTabChanged);
            addChild(_scriptTabs);
            
            // Create city selector
            _citySelector = new CitySelector();
            _citySelector.y = 50;
            addChild(_citySelector);
            
            // Create script editor
            _scriptEditor = new ScriptEditor();
            _scriptEditor.y = 100;
            addChild(_scriptEditor);
            
            // Create validation display
            _validationDisplay = new ValidationDisplay();
            _validationDisplay.y = 400;
            addChild(_validationDisplay);
            
            // Create status bar
            _statusBar = new StatusBar();
            _statusBar.y = 570;
            addChild(_statusBar);
            
            // Add control buttons
            createControlButtons();
        }
        
        private function createControlButtons():void {
            var buttonContainer:Sprite = new Sprite();
            buttonContainer.x = 700;
            buttonContainer.y = 10;
            
            // Run button
            var runButton:Button = new Button("Run", 0x00CC00);
            runButton.addEventListener(MouseEvent.CLICK, onRunClick);
            buttonContainer.addChild(runButton);
            
            // Stop button
            var stopButton:Button = new Button("Stop", 0xCC0000);
            stopButton.x = 60;
            stopButton.addEventListener(MouseEvent.CLICK, onStopClick);
            buttonContainer.addChild(stopButton);
            
            // Minimize button
            var minimizeButton:Button = new Button("_", 0x666666);
            minimizeButton.x = 120;
            minimizeButton.addEventListener(MouseEvent.CLICK, onMinimizeClick);
            buttonContainer.addChild(minimizeButton);
            
            addChild(buttonContainer);
        }
        
        /**
         * Load script into editor
         */
        public function loadScript(script:String, cities:Array = null):void {
            _scriptEditor.setContent(script);
            
            if (cities) {
                _citySelector.selectCities(cities);
            }
            
            // Validate script
            validateCurrentScript();
        }
        
        /**
         * Run current script
         */
        public function runScript():Object {
            var result:Object = {
                success: false,
                scriptId: "",
                errors: []
            };
            
            try {
                // Get current script
                var script:String = _scriptEditor.getContent();
                
                // Validate before running
                var validation:Object = _validator.validateScript(script);
                if (!validation.valid) {
                    throw new Error(
                        "Script validation failed: " + 
                        validation.errors.join(", ")
                    );
                }
                
                // Get selected cities
                var cities:Array = _citySelector.getSelectedCities();
                if (cities.length == 0) {
                    throw new Error("No cities selected");
                }
                
                // Generate script ID
                var scriptId:String = generateScriptId();
                
                // Add to active scripts
                _activeScripts[scriptId] = {
                    content: script,
                    cities: cities,
                    startTime: new Date().time,
                    status: "running"
                };
                
                // Add to history
                addToHistory(script, cities);
                
                // Send to RoboEvony
                RoboEvonyInterface.getInstance().sendToScriptWindow(
                    script,
                    _isGoalWindow ? "goal" : "action",
                    cities
                );
                
                result.success = true;
                result.scriptId = scriptId;
                
                // Update UI
                updateActiveScriptsDisplay();
                _statusBar.setStatus("Script running: " + scriptId);
                
            } catch (e:Error) {
                result.errors.push(e.message);
                _statusBar.setStatus("Error: " + e.message, true);
            }
            
            return result;
        }
        
        /**
         * Stop script
         */
        public function stopScript(scriptId:String = null):Boolean {
            if (!scriptId) {
                // Stop all active scripts
                var success:Boolean = true;
                for (var id:String in _activeScripts) {
                    if (!stopScript(id)) {
                        success = false;
                    }
                }
                return success;
            }
            
            try {
                if (_activeScripts[scriptId]) {
                    RoboEvonyInterface.getInstance().stopScript(scriptId);
                    _activeScripts[scriptId].status = "stopped";
                    updateActiveScriptsDisplay();
                    _statusBar.setStatus("Script stopped: " + scriptId);
                    return true;
                }
            } catch (e:Error) {
                _statusBar.setStatus("Error stopping script: " + e.message, true);
            }
            
            return false;
        }
        
        /**
         * Save script as template
         */
        public function saveAsTemplate(name:String):void {
            var script:String = _scriptEditor.getContent();
            var template:Object = {
                name: name,
                content: script,
                created: new Date().time,
                cities: _citySelector.getSelectedCities()
            };
            
            // Save template
            saveTemplate(template);
            _statusBar.setStatus("Template saved: " + name);
        }
        
        /**
         * Load template
         */
        public function loadTemplate(name:String):void {
            var template:Object = loadTemplateByName(name);
            if (template) {
                loadScript(template.content, template.cities);
                _statusBar.setStatus("Template loaded: " + name);
            }
        }
        
        // Event handlers
        private function onTabChanged(e:Event):void {
            var tab:String = _scriptTabs.selectedTab;
            
            switch (tab) {
                case "Active Scripts":
                    showActiveScripts();
                    break;
                case "Script Editor":
                    showScriptEditor();
                    break;
                case "History":
                    showHistory();
                    break;
                case "Templates":
                    showTemplates();
                    break;
            }
        }
        
        private function onRunClick(e:MouseEvent):void {
            runScript();
        }
        
        private function onStopClick(e:MouseEvent):void {
            stopScript();
        }
        
        private function onMinimizeClick(e:MouseEvent):void {
            toggleMinimize();
        }
        
        // UI update functions
        private function showActiveScripts():void {
            // Show active scripts panel
        }
        
        private function showScriptEditor():void {
            // Show script editor panel
        }
        
        private function showHistory():void {
            // Show script history panel
        }
        
        private function showTemplates():void {
            // Show templates panel
        }
        
        private function updateActiveScriptsDisplay():void {
            // Update active scripts display
        }
        
        private function validateCurrentScript():void {
            var script:String = _scriptEditor.getContent();
            var validation:Object = _validator.validateScript(script);
            _validationDisplay.showValidation(validation);
        }
        
        private function toggleMinimize():void {
            _isMinimized = !_isMinimized;
            if (_isMinimized) {
                minimize();
            } else {
                restore();
            }
        }
        
        // Helper functions
        private function generateScriptId():String {
            return new Date().time.toString() + 
                   "_" + 
                   Math.floor(Math.random() * 1000);
        }
        
        private function addToHistory(script:String, cities:Array):void {
            _scriptHistory.push({
                content: script,
                cities: cities,
                timestamp: new Date().time
            });
            
            // Keep history size manageable
            if (_scriptHistory.length > 100) {
                _scriptHistory.shift();
            }
        }
        
        private function loadSavedScripts():void {
            // Load saved scripts from storage
        }
        
        private function saveTemplate(template:Object):void {
            // Save template to storage
        }
        
        private function loadTemplateByName(name:String):Object {
            // Load template from storage
            return null;
        }
        
        private function minimize():void {
            // Minimize window
        }
        
        private function restore():void {
            // Restore window
        }
    }
}

// Supporting Classes
class Button extends Sprite {
    private var _label:TextField;
    
    public function Button(text:String, color:uint) {
        graphics.beginFill(color);
        graphics.drawRoundRect(0, 0, 50, 25, 5);
        graphics.endFill();
        
        _label = new TextField();
        _label.defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
        _label.text = text;
        _label.width = 50;
        _label.height = 25;
        _label.mouseEnabled = false;
        addChild(_label);
        
        this.buttonMode = true;
        this.mouseChildren = false;
    }
}

class CitySelector extends Sprite {
    private var _selectedCities:Array = [];
    
    public function selectCities(cities:Array):void {
        _selectedCities = cities;
        updateDisplay();
    }
    
    public function getSelectedCities():Array {
        return _selectedCities;
    }
    
    private function updateDisplay():void {
        // Update UI
    }
}

class ScriptEditor extends Sprite {
    private var _textField:TextField;
    
    public function setContent(content:String):void {
        _textField.text = content;
    }
    
    public function getContent():String {
        return _textField.text;
    }
}

class ValidationDisplay extends Sprite {
    public function showValidation(validation:Object):void {
        // Display validation results
    }
}

class StatusBar extends Sprite {
    private var _statusText:TextField;
    
    public function setStatus(text:String, isError:Boolean = false):void {
        _statusText.textColor = isError ? 0xFF0000 : 0xFFFFFF;
        _statusText.text = text;
    }
}
