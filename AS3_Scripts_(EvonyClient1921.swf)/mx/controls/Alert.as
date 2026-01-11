// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.Alert

package mx.controls
{
    import mx.containers.Panel;
    import mx.resources.IResourceManager;
    import mx.core.FlexVersion;
    import mx.controls.alertClasses.AlertForm;
    import flash.events.Event;
    import flash.events.EventPhase;
    import mx.core.IFlexDisplayObject;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    import mx.resources.ResourceManager;
    import mx.managers.ISystemManager;
    import mx.core.Application;
    import flash.display.Sprite;
    import mx.events.CloseEvent;
    import mx.core.UIComponent;
    import mx.core.EdgeMetrics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Alert extends Panel 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const YES:uint = 1;
        public static const NO:uint = 2;
        public static const OK:uint = 4;
        public static const CANCEL:uint = 8;
        public static const NONMODAL:uint = 0x8000;
        mx_internal static var createAccessibilityImplementation:Function;
        private static var _resourceManager:IResourceManager;
        private static var initialized:Boolean = false;
        public static var buttonHeight:Number = 22;
        public static var buttonWidth:Number = ((FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0) ? 60 : 65);
        private static var _cancelLabel:String;
        private static var cancelLabelOverride:String;
        private static var _noLabel:String;
        private static var noLabelOverride:String;
        private static var _okLabel:String;
        private static var okLabelOverride:String;
        private static var _yesLabel:String;
        private static var yesLabelOverride:String;

        mx_internal var alertForm:AlertForm;
        public var defaultButtonFlag:uint = 4;
        public var text:String = "";
        public var buttonFlags:uint = 4;
        public var iconClass:Class;

        public function Alert()
        {
            title = "";
        }

        private static function initialize():void
        {
            if (!initialized)
            {
                resourceManager.addEventListener(Event.CHANGE, static_resourceManager_changeHandler, false, 0, true);
                static_resourcesChanged();
                initialized = true;
            };
        }

        private static function static_resourcesChanged():void
        {
            cancelLabel = cancelLabelOverride;
            noLabel = noLabelOverride;
            okLabel = okLabelOverride;
            yesLabel = yesLabelOverride;
        }

        public static function get cancelLabel():String
        {
            initialize();
            return (_cancelLabel);
        }

        public static function set yesLabel(_arg_1:String):void
        {
            yesLabelOverride = _arg_1;
            _yesLabel = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("controls", "yesLabel"));
        }

        private static function static_creationCompleteHandler(_arg_1:FlexEvent):void
        {
            if (((_arg_1.target is IFlexDisplayObject) && (_arg_1.eventPhase == EventPhase.AT_TARGET)))
            {
                _arg_1.target.removeEventListener(FlexEvent.CREATION_COMPLETE, static_creationCompleteHandler);
                PopUpManager.centerPopUp(IFlexDisplayObject(_arg_1.target));
            };
        }

        public static function get noLabel():String
        {
            initialize();
            return (_noLabel);
        }

        public static function set cancelLabel(_arg_1:String):void
        {
            cancelLabelOverride = _arg_1;
            _cancelLabel = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("controls", "cancelLabel"));
        }

        private static function get resourceManager():IResourceManager
        {
            if (!_resourceManager)
            {
                _resourceManager = ResourceManager.getInstance();
            };
            return (_resourceManager);
        }

        public static function get yesLabel():String
        {
            initialize();
            return (_yesLabel);
        }

        public static function set noLabel(_arg_1:String):void
        {
            noLabelOverride = _arg_1;
            _noLabel = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("controls", "noLabel"));
        }

        private static function static_resourceManager_changeHandler(_arg_1:Event):void
        {
            static_resourcesChanged();
        }

        public static function set okLabel(_arg_1:String):void
        {
            okLabelOverride = _arg_1;
            _okLabel = ((_arg_1 != null) ? _arg_1 : resourceManager.getString("controls", "okLabel"));
        }

        public static function get okLabel():String
        {
            initialize();
            return (_okLabel);
        }

        public static function show(_arg_1:String="", _arg_2:String="", _arg_3:uint=4, _arg_4:Sprite=null, _arg_5:Function=null, _arg_6:Class=null, _arg_7:uint=4):Alert
        {
            var _local_10:ISystemManager;
            var _local_8:Boolean = ((_arg_3 & Alert.NONMODAL) ? false : true);
            if (!_arg_4)
            {
                _local_10 = ISystemManager(Application.application.systemManager);
                if (_local_10.useSWFBridge())
                {
                    _arg_4 = Sprite(_local_10.getSandboxRoot());
                }
                else
                {
                    _arg_4 = Sprite(Application.application);
                };
            };
            var _local_9:Alert = new (Alert)();
            if (((((_arg_3 & Alert.OK) || (_arg_3 & Alert.CANCEL)) || (_arg_3 & Alert.YES)) || (_arg_3 & Alert.NO)))
            {
                _local_9.buttonFlags = _arg_3;
            };
            if (((((_arg_7 == Alert.OK) || (_arg_7 == Alert.CANCEL)) || (_arg_7 == Alert.YES)) || (_arg_7 == Alert.NO)))
            {
                _local_9.defaultButtonFlag = _arg_7;
            };
            _local_9.text = _arg_1;
            _local_9.title = _arg_2;
            _local_9.iconClass = _arg_6;
            if (_arg_5 != null)
            {
                _local_9.addEventListener(CloseEvent.CLOSE, _arg_5);
            };
            if ((_arg_4 is UIComponent))
            {
                _local_9.moduleFactory = UIComponent(_arg_4).moduleFactory;
            };
            PopUpManager.addPopUp(_local_9, _arg_4, _local_8);
            _local_9.setActualSize(_local_9.getExplicitOrMeasuredWidth(), _local_9.getExplicitOrMeasuredHeight());
            _local_9.addEventListener(FlexEvent.CREATION_COMPLETE, static_creationCompleteHandler);
            return (_local_9);
        }


        override public function styleChanged(_arg_1:String):void
        {
            var _local_2:String;
            super.styleChanged(_arg_1);
            if (_arg_1 == "messageStyleName")
            {
                _local_2 = getStyle("messageStyleName");
                styleName = _local_2;
            };
            if (alertForm)
            {
                alertForm.styleChanged(_arg_1);
            };
        }

        override protected function measure():void
        {
            super.measure();
            var _local_1:EdgeMetrics = viewMetrics;
            measuredWidth = Math.max(measuredWidth, ((alertForm.getExplicitOrMeasuredWidth() + _local_1.left) + _local_1.right));
            measuredHeight = ((alertForm.getExplicitOrMeasuredHeight() + _local_1.top) + _local_1.bottom);
        }

        override protected function resourcesChanged():void
        {
            super.resourcesChanged();
            static_resourcesChanged();
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:EdgeMetrics = viewMetrics;
            alertForm.setActualSize(((((_arg_1 - _local_3.left) - _local_3.right) - getStyle("paddingLeft")) - getStyle("paddingRight")), ((((_arg_2 - _local_3.top) - _local_3.bottom) - getStyle("paddingTop")) - getStyle("paddingBottom")));
        }

        override protected function createChildren():void
        {
            super.createChildren();
            var _local_1:String = getStyle("messageStyleName");
            if (_local_1)
            {
                styleName = _local_1;
            };
            if (!alertForm)
            {
                alertForm = new AlertForm();
                alertForm.styleName = this;
                addChild(alertForm);
            };
        }

        override protected function initializeAccessibility():void
        {
            if (Alert.createAccessibilityImplementation != null)
            {
                Alert.createAccessibilityImplementation(this);
            };
        }


    }
}//package mx.controls

