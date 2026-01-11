package com.evony.useful {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    public class AICommandUI extends Sprite {
        private var _commandInput:TextField;
        private var _suggestionList:Sprite;
        private var _scriptPreview:TextField;
        private var _stateVisualizer:StateVisualizer;
        private var _suggestions:Array = [];
        private var _selectedSuggestion:int = -1;
        private var _nlpProcessor:NLPProcessor;
        private var _scriptGenerator:ScriptGenerator;
        
        // UI Constants
        private static const UI_WIDTH:Number = 800;
        private static const UI_HEIGHT:Number = 600;
        private static const PADDING:Number = 10;
        private static const INPUT_HEIGHT:Number = 30;
        private static const SUGGESTION_HEIGHT:Number = 25;
        private static const MAX_SUGGESTIONS:int = 5;
        
        public function AICommandUI() {
            _nlpProcessor = NLPProcessor.getInstance();
            _scriptGenerator = ScriptGenerator.getInstance();
            initialize();
        }
        
        /**
         * Initialize UI
         */
        private function initialize():void {
            createCommandInput();
            createSuggestionList();
            createScriptPreview();
            createStateVisualizer();
            
            // Add event listeners
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        /**
         * Create command input
         */
        private function createCommandInput():void {
            _commandInput = new TextField();
            _commandInput.width = UI_WIDTH - (PADDING * 2);
            _commandInput.height = INPUT_HEIGHT;
            _commandInput.x = PADDING;
            _commandInput.y = PADDING;
            _commandInput.border = true;
            _commandInput.borderColor = 0x666666;
            _commandInput.background = true;
            _commandInput.backgroundColor = 0xFFFFFF;
            _commandInput.type = TextFieldType.INPUT;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 14;
            _commandInput.defaultTextFormat = format;
            
            _commandInput.addEventListener(
                KeyboardEvent.KEY_UP,
                onCommandInput
            );
            
            addChild(_commandInput);
        }
        
        /**
         * Create suggestion list
         */
        private function createSuggestionList():void {
            _suggestionList = new Sprite();
            _suggestionList.x = PADDING;
            _suggestionList.y = _commandInput.y + INPUT_HEIGHT + PADDING;
            addChild(_suggestionList);
        }
        
        /**
         * Create script preview
         */
        private function createScriptPreview():void {
            _scriptPreview = new TextField();
            _scriptPreview.width = UI_WIDTH - (PADDING * 2);
            _scriptPreview.height = 200;
            _scriptPreview.x = PADDING;
            _scriptPreview.y = _suggestionList.y + 
                              (SUGGESTION_HEIGHT * MAX_SUGGESTIONS) + 
                              PADDING;
            _scriptPreview.border = true;
            _scriptPreview.borderColor = 0x666666;
            _scriptPreview.background = true;
            _scriptPreview.backgroundColor = 0xF0F0F0;
            _scriptPreview.wordWrap = true;
            _scriptPreview.multiline = true;
            
            var format:TextFormat = new TextFormat();
            format.font = "Courier New";
            format.size = 12;
            _scriptPreview.defaultTextFormat = format;
            
            addChild(_scriptPreview);
        }
        
        /**
         * Create state visualizer
         */
        private function createStateVisualizer():void {
            _stateVisualizer = new StateVisualizer();
            _stateVisualizer.x = PADDING;
            _stateVisualizer.y = _scriptPreview.y + 
                                _scriptPreview.height + 
                                PADDING;
            addChild(_stateVisualizer);
        }
        
        /**
         * Handle command input
         */
        private function onCommandInput(event:KeyboardEvent):void {
            var command:String = _commandInput.text;
            
            switch (event.keyCode) {
                case Keyboard.ENTER:
                    processCommand(command);
                    break;
                    
                case Keyboard.UP:
                    navigateSuggestions(-1);
                    break;
                    
                case Keyboard.DOWN:
                    navigateSuggestions(1);
                    break;
                    
                default:
                    updateSuggestions(command);
                    break;
            }
        }
        
        /**
         * Process command
         */
        private function processCommand(command:String):void {
            // Process with NLP
            var nlpResult:Object = _nlpProcessor.processCommand(
                command,
                getContext()
            );
            
            // Generate script
            if (nlpResult.success) {
                var scriptResult:Object = _scriptGenerator.generateScript(
                    nlpResult,
                    getContext()
                );
                
                if (scriptResult.success) {
                    updateScriptPreview(scriptResult.script);
                    updateStateVisualization(scriptResult.script);
                    
                    // Learn from successful command
                    _nlpProcessor.learn(command, scriptResult);
                }
            }
            
            // Clear input
            _commandInput.text = "";
            clearSuggestions();
        }
        
        /**
         * Update suggestions
         */
        private function updateSuggestions(partial:String):void {
            if (partial.length < 2) {
                clearSuggestions();
                return;
            }
            
            // Get suggestions
            _suggestions = _nlpProcessor.getSuggestions(
                partial,
                getContext()
            );
            
            // Update UI
            updateSuggestionList();
        }
        
        /**
         * Navigate suggestions
         */
        private function navigateSuggestions(direction:int):void {
            if (_suggestions.length == 0) return;
            
            _selectedSuggestion += direction;
            
            if (_selectedSuggestion < 0) {
                _selectedSuggestion = _suggestions.length - 1;
            } else if (_selectedSuggestion >= _suggestions.length) {
                _selectedSuggestion = 0;
            }
            
            // Update command input
            if (_selectedSuggestion >= 0) {
                _commandInput.text = _suggestions[_selectedSuggestion].text;
                _commandInput.setSelection(
                    _commandInput.text.length,
                    _commandInput.text.length
                );
            }
            
            // Update UI
            updateSuggestionList();
        }
        
        /**
         * Update suggestion list
         */
        private function updateSuggestionList():void {
            // Clear existing suggestions
            while (_suggestionList.numChildren > 0) {
                _suggestionList.removeChildAt(0);
            }
            
            // Add new suggestions
            var count:int = Math.min(_suggestions.length, MAX_SUGGESTIONS);
            for (var i:int = 0; i < count; i++) {
                var suggestion:Object = _suggestions[i];
                
                var item:TextField = new TextField();
                item.width = UI_WIDTH - (PADDING * 2);
                item.height = SUGGESTION_HEIGHT;
                item.y = i * SUGGESTION_HEIGHT;
                item.border = true;
                item.borderColor = 0x666666;
                item.background = true;
                item.backgroundColor = (i == _selectedSuggestion) ? 
                                     0xE0E0E0 : 0xFFFFFF;
                
                var format:TextFormat = new TextFormat();
                format.font = "_sans";
                format.size = 12;
                item.defaultTextFormat = format;
                
                item.text = suggestion.text;
                
                _suggestionList.addChild(item);
            }
        }
        
        /**
         * Clear suggestions
         */
        private function clearSuggestions():void {
            _suggestions = [];
            _selectedSuggestion = -1;
            updateSuggestionList();
        }
        
        /**
         * Update script preview
         */
        private function updateScriptPreview(script:Object):void {
            var preview:String = "Generated Script:\n\n";
            
            // Add script content
            for each (var content:Object in script.content) {
                preview += formatScriptContent(content) + "\n";
            }
            
            // Add validation info
            if (script.validation && script.validation.length > 0) {
                preview += "\nValidation:\n";
                for each (var validation:Object in script.validation) {
                    preview += "- " + validation.message + "\n";
                }
            }
            
            _scriptPreview.text = preview;
        }
        
        /**
         * Update state visualization
         */
        private function updateStateVisualization(script:Object):void {
            _stateVisualizer.updateState(script);
        }
        
        /**
         * Format script content
         */
        private function formatScriptContent(content:Object):String {
            var formatted:String = "";
            
            switch (content.type) {
                case "command":
                    formatted = "> " + content.command;
                    break;
                    
                case "condition":
                    formatted = "if " + content.condition + " then";
                    break;
                    
                case "loop":
                    formatted = "repeat " + content.count + " times:";
                    break;
                    
                default:
                    formatted = content.toString();
                    break;
            }
            
            return formatted;
        }
        
        /**
         * Get current context
         */
        private function getContext():Object {
            return {
                selectedSuggestion: _selectedSuggestion,
                suggestions: _suggestions,
                currentScript: _scriptPreview.text,
                gameState: _stateVisualizer.getState()
            };
        }
        
        /**
         * Added to stage handler
         */
        private function onAddedToStage(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            
            // Set initial state
            _commandInput.text = "";
            clearSuggestions();
            _scriptPreview.text = "No script generated yet.";
        }
    }
}
