package com.evony.useful {
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class StateVisualizer extends Sprite {
        private var _container:Sprite;
        private var _cityViews:Object = {};
        private var _resourceViews:Object = {};
        private var _troopViews:Object = {};
        private var _currentState:Object = {};
        
        // Visualization Constants
        private static const VIEW_WIDTH:Number = 780;
        private static const VIEW_HEIGHT:Number = 300;
        private static const CITY_SIZE:Number = 100;
        private static const RESOURCE_HEIGHT:Number = 60;
        private static const TROOP_HEIGHT:Number = 40;
        private static const PADDING:Number = 10;
        
        // Colors
        private static const COLORS:Object = {
            background: 0xF0F0F0,
            city: 0xCCCCCC,
            resource: {
                food: 0x90EE90,
                wood: 0x8B4513,
                stone: 0x808080,
                iron: 0xCD853F,
                gold: 0xFFD700
            },
            troops: {
                warrior: 0xFF0000,
                archer: 0x00FF00,
                cavalry: 0x0000FF,
                siege: 0xFF00FF
            }
        };
        
        public function StateVisualizer() {
            initialize();
        }
        
        /**
         * Initialize visualizer
         */
        private function initialize():void {
            createContainer();
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        /**
         * Update state visualization
         */
        public function updateState(state:Object):void {
            _currentState = state;
            
            // Clear existing views
            clearViews();
            
            // Create new views
            createCityViews(state.cities);
            createResourceViews(state.resources);
            createTroopViews(state.troops);
            
            // Update layout
            updateLayout();
        }
        
        /**
         * Get current state
         */
        public function getState():Object {
            return _currentState;
        }
        
        /**
         * Create container
         */
        private function createContainer():void {
            _container = new Sprite();
            addChild(_container);
            
            // Draw background
            var g:Graphics = _container.graphics;
            g.beginFill(COLORS.background);
            g.drawRect(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
            g.endFill();
        }
        
        /**
         * Create city views
         */
        private function createCityViews(cities:Object):void {
            for (var cityId:String in cities) {
                var city:Object = cities[cityId];
                
                var cityView:Sprite = new Sprite();
                
                // Draw city
                var g:Graphics = cityView.graphics;
                g.beginFill(COLORS.city);
                g.drawRect(0, 0, CITY_SIZE, CITY_SIZE);
                g.endFill();
                
                // Add city name
                var nameField:TextField = new TextField();
                nameField.width = CITY_SIZE;
                nameField.height = 20;
                nameField.y = CITY_SIZE + 5;
                
                var format:TextFormat = new TextFormat();
                format.font = "_sans";
                format.size = 12;
                format.align = "center";
                nameField.defaultTextFormat = format;
                
                nameField.text = city.name;
                cityView.addChild(nameField);
                
                // Add level indicator
                var levelField:TextField = new TextField();
                levelField.width = 30;
                levelField.height = 20;
                levelField.x = CITY_SIZE - 30;
                
                format = new TextFormat();
                format.font = "_sans";
                format.size = 12;
                format.color = 0xFFFFFF;
                levelField.defaultTextFormat = format;
                
                levelField.text = "L" + city.level;
                cityView.addChild(levelField);
                
                // Store view
                _cityViews[cityId] = cityView;
                _container.addChild(cityView);
            }
        }
        
        /**
         * Create resource views
         */
        private function createResourceViews(resources:Object):void {
            for (var cityId:String in resources) {
                var cityResources:Object = resources[cityId];
                var resourceView:Sprite = new Sprite();
                
                var y:Number = 0;
                for (var type:String in COLORS.resource) {
                    if (cityResources[type]) {
                        // Create resource bar
                        var bar:Sprite = createResourceBar(
                            type,
                            cityResources[type],
                            cityResources[type + "Capacity"]
                        );
                        bar.y = y;
                        resourceView.addChild(bar);
                        y += RESOURCE_HEIGHT / 5;
                    }
                }
                
                // Store view
                _resourceViews[cityId] = resourceView;
                _container.addChild(resourceView);
            }
        }
        
        /**
         * Create troop views
         */
        private function createTroopViews(troops:Object):void {
            for (var cityId:String in troops) {
                var cityTroops:Object = troops[cityId];
                var troopView:Sprite = new Sprite();
                
                var x:Number = 0;
                for (var type:String in COLORS.troops) {
                    if (cityTroops[type]) {
                        // Create troop indicator
                        var indicator:Sprite = createTroopIndicator(
                            type,
                            cityTroops[type]
                        );
                        indicator.x = x;
                        troopView.addChild(indicator);
                        x += TROOP_HEIGHT;
                    }
                }
                
                // Store view
                _troopViews[cityId] = troopView;
                _container.addChild(troopView);
            }
        }
        
        /**
         * Create resource bar
         */
        private function createResourceBar(
            type:String,
            amount:Number,
            capacity:Number
        ):Sprite {
            var bar:Sprite = new Sprite();
            var g:Graphics = bar.graphics;
            
            // Draw background
            g.beginFill(0xEEEEEE);
            g.drawRect(0, 0, 100, 10);
            g.endFill();
            
            // Draw fill
            var fillWidth:Number = Math.min(
                100 * (amount / capacity),
                100
            );
            g.beginFill(COLORS.resource[type]);
            g.drawRect(0, 0, fillWidth, 10);
            g.endFill();
            
            // Add label
            var label:TextField = new TextField();
            label.width = 100;
            label.height = 15;
            label.y = -15;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 10;
            label.defaultTextFormat = format;
            
            label.text = type + ": " + amount + "/" + capacity;
            bar.addChild(label);
            
            return bar;
        }
        
        /**
         * Create troop indicator
         */
        private function createTroopIndicator(
            type:String,
            count:Number
        ):Sprite {
            var indicator:Sprite = new Sprite();
            var g:Graphics = indicator.graphics;
            
            // Draw icon
            g.beginFill(COLORS.troops[type]);
            g.drawCircle(TROOP_HEIGHT/2, TROOP_HEIGHT/2, TROOP_HEIGHT/2);
            g.endFill();
            
            // Add count
            var countField:TextField = new TextField();
            countField.width = TROOP_HEIGHT;
            countField.height = 20;
            countField.y = TROOP_HEIGHT;
            
            var format:TextFormat = new TextFormat();
            format.font = "_sans";
            format.size = 10;
            format.align = "center";
            countField.defaultTextFormat = format;
            
            countField.text = String(count);
            indicator.addChild(countField);
            
            return indicator;
        }
        
        /**
         * Update layout
         */
        private function updateLayout():void {
            var x:Number = PADDING;
            var y:Number = PADDING;
            
            // Position cities
            for (var cityId:String in _cityViews) {
                var cityView:Sprite = _cityViews[cityId];
                cityView.x = x;
                cityView.y = y;
                
                // Position resources
                if (_resourceViews[cityId]) {
                    var resourceView:Sprite = _resourceViews[cityId];
                    resourceView.x = x + CITY_SIZE + PADDING;
                    resourceView.y = y;
                }
                
                // Position troops
                if (_troopViews[cityId]) {
                    var troopView:Sprite = _troopViews[cityId];
                    troopView.x = x;
                    troopView.y = y + CITY_SIZE + 30;
                }
                
                x += CITY_SIZE + 150;
                if (x + CITY_SIZE > VIEW_WIDTH) {
                    x = PADDING;
                    y += CITY_SIZE + 100;
                }
            }
        }
        
        /**
         * Clear views
         */
        private function clearViews():void {
            // Clear cities
            for each (var cityView:Sprite in _cityViews) {
                _container.removeChild(cityView);
            }
            _cityViews = {};
            
            // Clear resources
            for each (var resourceView:Sprite in _resourceViews) {
                _container.removeChild(resourceView);
            }
            _resourceViews = {};
            
            // Clear troops
            for each (var troopView:Sprite in _troopViews) {
                _container.removeChild(troopView);
            }
            _troopViews = {};
        }
        
        /**
         * Added to stage handler
         */
        private function onAddedToStage(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            
            // Set initial state
            updateState({
                cities: {},
                resources: {},
                troops: {}
            });
        }
    }
}
