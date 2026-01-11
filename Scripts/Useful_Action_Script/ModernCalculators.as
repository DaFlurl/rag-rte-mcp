package com.evony.useful {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class ModernCalculators extends Sprite {
        private var _scriptManager:ScriptManager;
        private var _tabs:TabBar;
        private var _contentArea:Sprite;
        private var _resultDisplay:ResultDisplay;
        
        // New calculator types
        private const CALCULATOR_TYPES:Array = [
            {
                name: "Resource Calculator",
                type: "resource",
                features: [
                    "Food Production/Consumption",
                    "Resource Generation Rates",
                    "Storage Capacity",
                    "Transport Requirements"
                ]
            },
            {
                name: "Battle Calculator",
                type: "battle",
                features: [
                    "Army Strength Analysis",
                    "Defense Requirements",
                    "Counter Unit Suggestions",
                    "Rally Point Planning"
                ]
            },
            {
                name: "Time Calculator",
                type: "time",
                features: [
                    "Build Times",
                    "Research Duration",
                    "March Calculations",
                    "Buff Duration Tracking"
                ]
            },
            {
                name: "Efficiency Calculator",
                type: "efficiency",
                features: [
                    "Resource/Time Ratios",
                    "Optimal Build Orders",
                    "Upgrade Priority",
                    "Cost/Benefit Analysis"
                ]
            },
            {
                name: "Rally Calculator",
                type: "rally",
                features: [
                    "Multi-City Coordination",
                    "Timing Synchronization",
                    "Distance Planning",
                    "Formation Optimization"
                ]
            }
        ];
        
        public function ModernCalculators() {
            _scriptManager = ScriptManager.getInstance();
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void {
            if (e) removeEventListener(Event.ADDED_TO_STAGE, init);
            createUI();
        }
        
        private function createUI():void {
            // Create tabs for calculator types
            var tabNames:Array = CALCULATOR_TYPES.map(function(calc:Object):String {
                return calc.name;
            });
            
            _tabs = new TabBar(tabNames);
            _tabs.y = 10;
            _tabs.addEventListener("tabChanged", onTabChanged);
            addChild(_tabs);
            
            // Create content area
            _contentArea = new Sprite();
            _contentArea.y = 50;
            addChild(_contentArea);
            
            // Create result display
            _resultDisplay = new ResultDisplay();
            _resultDisplay.y = 400;
            addChild(_resultDisplay);
            
            // Show first calculator by default
            showCalculator(CALCULATOR_TYPES[0]);
        }
        
        private function onTabChanged(e:Event):void {
            var selectedCalc:Object = CALCULATOR_TYPES.find(
                function(calc:Object):Boolean {
                    return calc.name == _tabs.selectedTab;
                }
            );
            
            if (selectedCalc) {
                showCalculator(selectedCalc);
            }
        }
        
        private function showCalculator(calculator:Object):void {
            clearContent();
            
            // Create calculator view
            var view:CalculatorView = new CalculatorView(
                calculator.name,
                calculator.features
            );
            view.addEventListener("calculate", onCalculate);
            _contentArea.addChild(view);
            
            // Load related scripts
            var scripts:Array = _scriptManager.getScripts().filter(
                function(script:Object):Boolean {
                    return script.metadata.type == calculator.type;
                }
            );
            
            view.setScripts(scripts);
        }
        
        private function clearContent():void {
            while (_contentArea.numChildren > 0) {
                _contentArea.removeChildAt(0);
            }
        }
        
        private function onCalculate(e:Event):void {
            var data:Object = e.data;
            var result:Object;
            
            // Execute calculation based on type
            switch (data.type) {
                case "resource":
                    result = calculateResources(data);
                    break;
                case "battle":
                    result = calculateBattle(data);
                    break;
                case "time":
                    result = calculateTime(data);
                    break;
                case "efficiency":
                    result = calculateEfficiency(data);
                    break;
                case "rally":
                    result = calculateRally(data);
                    break;
            }
            
            // Display results
            _resultDisplay.showResult(result);
            
            // Save calculation as script if requested
            if (data.saveAsScript) {
                saveCalculation(data.type, result);
            }
        }
        
        private function calculateResources(data:Object):Object {
            // Implementation for resource calculations
            return {
                production: calculateProduction(data),
                consumption: calculateConsumption(data),
                storage: calculateStorage(data),
                transport: calculateTransport(data)
            };
        }
        
        private function calculateBattle(data:Object):Object {
            // Implementation for battle calculations
            return {
                strength: calculateStrength(data),
                defense: calculateDefense(data),
                counters: suggestCounters(data),
                rally: planRally(data)
            };
        }
        
        private function calculateTime(data:Object):Object {
            // Implementation for time calculations
            return {
                build: calculateBuildTime(data),
                research: calculateResearchTime(data),
                march: calculateMarchTime(data),
                buffs: calculateBuffDuration(data)
            };
        }
        
        private function calculateEfficiency(data:Object):Object {
            // Implementation for efficiency calculations
            return {
                ratios: calculateRatios(data),
                buildOrder: optimizeBuildOrder(data),
                priority: calculatePriority(data),
                costBenefit: analyzeCostBenefit(data)
            };
        }
        
        private function calculateRally(data:Object):Object {
            // Implementation for rally calculations
            return {
                coordination: coordinateCities(data),
                timing: synchronizeTiming(data),
                distance: planDistance(data),
                formation: optimizeFormation(data)
            };
        }
        
        private function saveCalculation(type:String, result:Object):void {
            var timestamp:String = new Date().time.toString();
            var name:String = type + "_calculation_" + timestamp;
            
            var content:String = "// " + type.toUpperCase() + " Calculation\n" +
                               "// Generated: " + new Date().toString() + "\n\n" +
                               "var result:Object = " + 
                               JSON.stringify(result, null, 2) + ";\n";
            
            _scriptManager.createScript(name, content, type);
        }
        
        // Helper calculation functions
        private function calculateProduction(data:Object):Object { return {}; }
        private function calculateConsumption(data:Object):Object { return {}; }
        private function calculateStorage(data:Object):Object { return {}; }
        private function calculateTransport(data:Object):Object { return {}; }
        private function calculateStrength(data:Object):Object { return {}; }
        private function calculateDefense(data:Object):Object { return {}; }
        private function suggestCounters(data:Object):Object { return {}; }
        private function planRally(data:Object):Object { return {}; }
        private function calculateBuildTime(data:Object):Object { return {}; }
        private function calculateResearchTime(data:Object):Object { return {}; }
        private function calculateMarchTime(data:Object):Object { return {}; }
        private function calculateBuffDuration(data:Object):Object { return {}; }
        private function calculateRatios(data:Object):Object { return {}; }
        private function optimizeBuildOrder(data:Object):Object { return {}; }
        private function calculatePriority(data:Object):Object { return {}; }
        private function analyzeCostBenefit(data:Object):Object { return {}; }
        private function coordinateCities(data:Object):Object { return {}; }
        private function synchronizeTiming(data:Object):Object { return {}; }
        private function planDistance(data:Object):Object { return {}; }
        private function optimizeFormation(data:Object):Object { return {}; }
    }
}

class CalculatorView extends Sprite {
    private var _name:String;
    private var _features:Array;
    private var _scripts:Array;
    
    public function CalculatorView(name:String, features:Array) {
        _name = name;
        _features = features;
        createUI();
    }
    
    private function createUI():void {
        // Create modern, clean UI for calculator
        graphics.beginFill(0x333333);
        graphics.drawRoundRect(0, 0, 700, 300, 10);
        graphics.endFill();
        
        // Add title
        var title:TextField = new TextField();
        title.defaultTextFormat = new TextFormat("_sans", 16, 0xFFFFFF, true);
        title.text = _name;
        title.x = 20;
        title.y = 10;
        title.width = 660;
        addChild(title);
        
        // Add features
        var yPos:Number = 50;
        for each (var feature:String in _features) {
            var button:FeatureButton = new FeatureButton(feature);
            button.x = 20;
            button.y = yPos;
            button.addEventListener(MouseEvent.CLICK, onFeatureClick);
            addChild(button);
            yPos += 40;
        }
    }
    
    public function setScripts(scripts:Array):void {
        _scripts = scripts;
        // Update UI to show available scripts
    }
    
    private function onFeatureClick(e:MouseEvent):void {
        var button:FeatureButton = e.currentTarget as FeatureButton;
        // Handle feature calculation
    }
}

class FeatureButton extends Sprite {
    private var _label:TextField;
    
    public function FeatureButton(text:String) {
        graphics.beginFill(0x444444);
        graphics.drawRoundRect(0, 0, 660, 30, 5);
        graphics.endFill();
        
        _label = new TextField();
        _label.defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
        _label.text = text;
        _label.x = 10;
        _label.y = 5;
        _label.width = 640;
        _label.mouseEnabled = false;
        addChild(_label);
        
        this.buttonMode = true;
        this.mouseChildren = false;
    }
}
