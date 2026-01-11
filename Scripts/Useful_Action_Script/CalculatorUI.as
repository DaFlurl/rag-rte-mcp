package com.evony.useful {
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    public class CalculatorUI extends Sprite {
        // UI Components
        private var _tabs:TabBar;
        private var _contentArea:Sprite;
        private var _resultDisplay:ResultDisplay;
        
        // Calculator instances
        private var _troopCalc:TroopOperations;
        private var _valleyCalc:ValleyOperations;
        private var _sequencePlanner:SequencePlanner;
        
        // Tab names
        private const TAB_NAMES:Array = [
            "Troop Calculator",
            "Valley Operations",
            "Sequence Planner",
            "Recovery Tools"
        ];
        
        public function CalculatorUI() {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void {
            if (e) removeEventListener(Event.ADDED_TO_STAGE, init);
            
            createUI();
            initializeCalculators();
        }
        
        private function createUI():void {
            // Create main container
            graphics.beginFill(0x333333);
            graphics.drawRect(0, 0, 800, 600);
            graphics.endFill();
            
            // Create tabs
            _tabs = new TabBar(TAB_NAMES);
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
        }
        
        private function initializeCalculators():void {
            _troopCalc = new TroopOperations();
            _valleyCalc = new ValleyOperations();
            _sequencePlanner = new SequencePlanner();
            
            showTroopCalculator(); // Default view
        }
        
        private function onTabChanged(e:Event):void {
            clearContent();
            
            switch (_tabs.selectedTab) {
                case "Troop Calculator":
                    showTroopCalculator();
                    break;
                case "Valley Operations":
                    showValleyCalculator();
                    break;
                case "Sequence Planner":
                    showSequencePlanner();
                    break;
                case "Recovery Tools":
                    showRecoveryTools();
                    break;
            }
        }
        
        private function clearContent():void {
            while (_contentArea.numChildren > 0) {
                _contentArea.removeChildAt(0);
            }
        }
        
        private function showTroopCalculator():void {
            var calculator:TroopCalculatorView = new TroopCalculatorView();
            calculator.addEventListener("calculate", onTroopCalculate);
            _contentArea.addChild(calculator);
        }
        
        private function showValleyCalculator():void {
            var calculator:ValleyCalculatorView = new ValleyCalculatorView();
            calculator.addEventListener("calculate", onValleyCalculate);
            _contentArea.addChild(calculator);
        }
        
        private function showSequencePlanner():void {
            var planner:SequencePlannerView = new SequencePlannerView();
            planner.addEventListener("plan", onSequencePlan);
            _contentArea.addChild(planner);
        }
        
        private function showRecoveryTools():void {
            var recovery:RecoveryToolsView = new RecoveryToolsView();
            recovery.addEventListener("calculate", onRecoveryCalculate);
            _contentArea.addChild(recovery);
        }
        
        private function onTroopCalculate(e:Event):void {
            var data:Object = e.data;
            var result:Object;
            
            switch (data.operation) {
                case "split":
                    result = _troopCalc.calculateSafeSplit(data.troopCount);
                    break;
                case "food":
                    result = _troopCalc.calculateFoodConsumption(data.troops);
                    break;
                case "distribution":
                    result = _troopCalc.calculateCityDistribution(
                        data.totalTroops,
                        data.cityCount
                    );
                    break;
            }
            
            _resultDisplay.showResult(result);
        }
        
        private function onValleyCalculate(e:Event):void {
            var data:Object = e.data;
            var result:Object;
            
            switch (data.operation) {
                case "thunder":
                    result = _valleyCalc.calculateThunderRaid(
                        data.troops,
                        data.distance
                    );
                    break;
                case "chain":
                    result = _valleyCalc.calculateValleyChain(
                        data.troops,
                        data.valleyCount
                    );
                    break;
            }
            
            _resultDisplay.showResult(result);
        }
        
        private function onSequencePlan(e:Event):void {
            var data:Object = e.data;
            var result:Object = _sequencePlanner.planSequence(
                data.operations,
                data.constraints
            );
            
            _resultDisplay.showResult(result);
        }
        
        private function onRecoveryCalculate(e:Event):void {
            var data:Object = e.data;
            var result:Object = _valleyCalc.calculateValleyRecovery(
                data.troops,
                data.isNegative
            );
            
            _resultDisplay.showResult(result);
        }
    }
}

// Supporting Classes
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;

class TabBar extends Sprite {
    private var _tabs:Array = [];
    private var _selectedTab:String;
    
    public function TabBar(tabNames:Array) {
        createTabs(tabNames);
    }
    
    private function createTabs(names:Array):void {
        var xPos:Number = 10;
        
        for each (var name:String in names) {
            var tab:Tab = new Tab(name);
            tab.x = xPos;
            tab.addEventListener(MouseEvent.CLICK, onTabClick);
            addChild(tab);
            
            _tabs.push(tab);
            xPos += tab.width + 5;
        }
        
        if (_tabs.length > 0) {
            selectTab(_tabs[0]);
        }
    }
    
    private function onTabClick(e:MouseEvent):void {
        var tab:Tab = e.currentTarget as Tab;
        selectTab(tab);
        dispatchEvent(new Event("tabChanged"));
    }
    
    private function selectTab(tab:Tab):void {
        for each (var t:Tab in _tabs) {
            t.selected = (t == tab);
        }
        _selectedTab = tab.label;
    }
    
    public function get selectedTab():String {
        return _selectedTab;
    }
}

class Tab extends Sprite {
    private var _label:TextField;
    private var _selected:Boolean;
    
    public function Tab(label:String) {
        _label = new TextField();
        _label.defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
        _label.text = label;
        _label.width = 120;
        _label.height = 25;
        _label.mouseEnabled = false;
        
        addChild(_label);
        draw();
        
        this.buttonMode = true;
        this.mouseChildren = false;
    }
    
    private function draw():void {
        graphics.clear();
        graphics.beginFill(_selected ? 0x666666 : 0x444444);
        graphics.drawRect(0, 0, 120, 25);
        graphics.endFill();
    }
    
    public function set selected(value:Boolean):void {
        _selected = value;
        draw();
    }
    
    public function get label():String {
        return _label.text;
    }
}

class ResultDisplay extends Sprite {
    private var _textField:TextField;
    
    public function ResultDisplay() {
        graphics.beginFill(0x444444);
        graphics.drawRect(0, 0, 780, 180);
        graphics.endFill();
        
        _textField = new TextField();
        _textField.defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
        _textField.width = 760;
        _textField.height = 160;
        _textField.x = 10;
        _textField.y = 10;
        _textField.multiline = true;
        _textField.wordWrap = true;
        addChild(_textField);
    }
    
    public function showResult(result:Object):void {
        var text:String = "";
        
        // Format warnings
        if (result.warnings && result.warnings.length > 0) {
            text += "Warnings:\n";
            for each (var warning:String in result.warnings) {
                text += "• " + warning + "\n";
            }
            text += "\n";
        }
        
        // Format recommendations
        if (result.recommendations && result.recommendations.length > 0) {
            text += "Recommendations:\n";
            for each (var rec:String in result.recommendations) {
                text += "• " + rec + "\n";
            }
            text += "\n";
        }
        
        // Format operations
        if (result.operations && result.operations.length > 0) {
            text += "Operations:\n";
            for each (var op:Object in result.operations) {
                text += "Step " + op.step + ": " + formatNumber(op.amount) + 
                       " troops (Wait: " + op.waitTime + " minutes)\n";
            }
            text += "\n";
        }
        
        // Format other properties
        for (var prop:String in result) {
            if (prop != "warnings" && prop != "recommendations" && 
                prop != "operations") {
                text += prop + ": " + formatValue(result[prop]) + "\n";
            }
        }
        
        _textField.text = text;
    }
    
    private function formatNumber(value:Number):String {
        return value.toLocaleString();
    }
    
    private function formatValue(value:*):String {
        if (value is Number) {
            return formatNumber(value);
        }
        return value.toString();
    }
}
