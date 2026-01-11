package com.evony.useful {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class AITemplateUI extends Sprite {
        private var _container:Sprite;
        private var _templateList:Sprite;
        private var _templateEditor:Sprite;
        private var _actionManager:AIActionManager;
        private var _selectedTemplate:Object;
        
        // UI Constants
        private static const UI_WIDTH:Number = 800;
        private static const UI_HEIGHT:Number = 600;
        private static const PADDING:Number = 10;
        private static const LIST_WIDTH:Number = 200;
        private static const EDITOR_WIDTH:Number = 580;
        
        public function AITemplateUI() {
            _actionManager = AIActionManager.getInstance();
            initialize();
        }
        
        /**
         * Initialize UI
         */
        private function initialize():void {
            createContainer();
            createTemplateList();
            createTemplateEditor();
            
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        /**
         * Create template
         */
        public function createTemplate(
            name:String,
            type:String,
            config:Object
        ):void {
            var result:Object = _actionManager.createTemplate(
                name,
                type,
                config
            );
            
            if (result.success) {
                updateTemplateList();
                selectTemplate(result.templateId);
            }
        }
        
        /**
         * Execute template
         */
        public function executeTemplate(
            templateId:String,
            targetCity:Object
        ):void {
            var result:Object = _actionManager.executeTemplate(
                templateId,
                targetCity
            );
            
            if (result.success) {
                updateActionStatus(result.actionId);
            }
        }
        
        // UI Creation
        private function createContainer():void {
            _container = new Sprite();
            addChild(_container);
            
            // Draw background
            var g:Graphics = _container.graphics;
            g.beginFill(0xF0F0F0);
            g.drawRect(0, 0, UI_WIDTH, UI_HEIGHT);
            g.endFill();
        }
        
        private function createTemplateList():void {
            _templateList = new Sprite();
            _templateList.x = PADDING;
            _templateList.y = PADDING;
            _container.addChild(_templateList);
            
            // Draw background
            var g:Graphics = _templateList.graphics;
            g.beginFill(0xFFFFFF);
            g.drawRect(0, 0, LIST_WIDTH, UI_HEIGHT - (PADDING * 2));
            g.endFill();
            
            // Add title
            var title:TextField = new TextField();
            title.width = LIST_WIDTH;
            title.height = 30;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 14;
            format.bold = true;
            title.defaultTextFormat = format;
            
            title.text = "Templates";
            _templateList.addChild(title);
            
            // Add templates
            updateTemplateList();
        }
        
        private function createTemplateEditor():void {
            _templateEditor = new Sprite();
            _templateEditor.x = LIST_WIDTH + (PADDING * 2);
            _templateEditor.y = PADDING;
            _container.addChild(_templateEditor);
            
            // Draw background
            var g:Graphics = _templateEditor.graphics;
            g.beginFill(0xFFFFFF);
            g.drawRect(0, 0, EDITOR_WIDTH, UI_HEIGHT - (PADDING * 2));
            g.endFill();
            
            // Add title
            var title:TextField = new TextField();
            title.width = EDITOR_WIDTH;
            title.height = 30;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 14;
            format.bold = true;
            title.defaultTextFormat = format;
            
            title.text = "Template Editor";
            _templateEditor.addChild(title);
        }
        
        private function updateTemplateList():void {
            // Clear existing items
            while (_templateList.numChildren > 1) {
                _templateList.removeChildAt(1);
            }
            
            // Add template items
            var y:Number = 40;
            for (var id:String in _actionManager.templates) {
                var template:Object = _actionManager.getTemplate(id);
                
                var item:Sprite = createTemplateItem(template);
                item.y = y;
                _templateList.addChild(item);
                
                y += item.height + 5;
            }
        }
        
        private function createTemplateItem(template:Object):Sprite {
            var item:Sprite = new Sprite();
            
            // Draw background
            var g:Graphics = item.graphics;
            g.beginFill(0xF8F8F8);
            g.drawRect(0, 0, LIST_WIDTH - 10, 50);
            g.endFill();
            
            // Add name
            var nameField:TextField = new TextField();
            nameField.width = LIST_WIDTH - 20;
            nameField.height = 20;
            nameField.x = 5;
            nameField.y = 5;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 12;
            nameField.defaultTextFormat = format;
            
            nameField.text = template.name;
            item.addChild(nameField);
            
            // Add type
            var typeField:TextField = new TextField();
            typeField.width = LIST_WIDTH - 20;
            typeField.height = 20;
            typeField.x = 5;
            typeField.y = 25;
            
            format = new TextFormat();
            format.font = "_sans";
            format.size = 10;
            format.color = 0x666666;
            typeField.defaultTextFormat = format;
            
            typeField.text = template.type;
            item.addChild(typeField);
            
            // Add click handler
            item.addEventListener(
                MouseEvent.CLICK,
                function(e:MouseEvent):void {
                    selectTemplate(template.id);
                }
            );
            
            return item;
        }
        
        private function selectTemplate(templateId:String):void {
            _selectedTemplate = _actionManager.getTemplate(templateId);
            updateTemplateEditor();
        }
        
        private function updateTemplateEditor():void {
            // Clear existing content
            while (_templateEditor.numChildren > 1) {
                _templateEditor.removeChildAt(1);
            }
            
            if (!_selectedTemplate) return;
            
            // Add template content
            var y:Number = 40;
            
            // Add name
            y = addEditorField("Name", _selectedTemplate.name, y);
            
            // Add type
            y = addEditorField("Type", _selectedTemplate.type, y);
            
            // Add configuration
            y = addEditorConfig(_selectedTemplate.config, y);
            
            // Add buttons
            addEditorButtons(y);
        }
        
        private function addEditorField(
            label:String,
            value:String,
            y:Number
        ):Number {
            // Add label
            var labelField:TextField = new TextField();
            labelField.width = 100;
            labelField.height = 20;
            labelField.x = 0;
            labelField.y = y;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 12;
            format.bold = true;
            labelField.defaultTextFormat = format;
            
            labelField.text = label + ":";
            _templateEditor.addChild(labelField);
            
            // Add value
            var valueField:TextField = new TextField();
            valueField.width = EDITOR_WIDTH - 120;
            valueField.height = 20;
            valueField.x = 110;
            valueField.y = y;
            valueField.border = true;
            valueField.borderColor = 0xCCCCCC;
            
            format = new TextFormat();
            format.font = "_sans";
            format.size = 12;
            valueField.defaultTextFormat = format;
            
            valueField.text = value;
            _templateEditor.addChild(valueField);
            
            return y + 30;
        }
        
        private function addEditorConfig(
            config:Object,
            y:Number
        ):Number {
            // Add config title
            var title:TextField = new TextField();
            title.width = EDITOR_WIDTH;
            title.height = 20;
            title.y = y;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 12;
            format.bold = true;
            title.defaultTextFormat = format;
            
            title.text = "Configuration:";
            _templateEditor.addChild(title);
            
            y += 30;
            
            // Add config fields
            for (var key:String in config) {
                y = addEditorField(key, config[key].toString(), y);
            }
            
            return y;
        }
        
        private function addEditorButtons(y:Number):void {
            // Add execute button
            var executeBtn:Sprite = createButton(
                "Execute",
                function():void {
                    onExecuteTemplate();
                }
            );
            executeBtn.x = EDITOR_WIDTH - 200;
            executeBtn.y = y;
            _templateEditor.addChild(executeBtn);
            
            // Add delete button
            var deleteBtn:Sprite = createButton(
                "Delete",
                function():void {
                    onDeleteTemplate();
                }
            );
            deleteBtn.x = EDITOR_WIDTH - 100;
            deleteBtn.y = y;
            _templateEditor.addChild(deleteBtn);
        }
        
        private function createButton(
            label:String,
            callback:Function
        ):Sprite {
            var button:Sprite = new Sprite();
            
            // Draw background
            var g:Graphics = button.graphics;
            g.beginFill(0x4CAF50);
            g.drawRoundRect(0, 0, 80, 30, 5);
            g.endFill();
            
            // Add label
            var labelField:TextField = new TextField();
            labelField.width = 80;
            labelField.height = 30;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 12;
            format.color = 0xFFFFFF;
            format.align = "center";
            labelField.defaultTextFormat = format;
            
            labelField.text = label;
            labelField.y = 5;
            button.addChild(labelField);
            
            // Add click handler
            button.addEventListener(
                MouseEvent.CLICK,
                function(e:MouseEvent):void {
                    callback();
                }
            );
            
            return button;
        }
        
        private function onExecuteTemplate():void {
            if (!_selectedTemplate) return;
            
            // Show city selector
            // Implementation needed
        }
        
        private function onDeleteTemplate():void {
            if (!_selectedTemplate) return;
            
            // Delete template
            // Implementation needed
        }
        
        private function updateActionStatus(actionId:String):void {
            // Update action status
            // Implementation needed
        }
        
        private function onAddedToStage(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            
            // Set initial state
            updateTemplateList();
        }
    }
}
