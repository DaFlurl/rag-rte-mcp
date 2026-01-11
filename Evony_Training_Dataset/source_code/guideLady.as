// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.guide.guideLady

package view.module.guide
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import flash.media.Sound;
    import mx.core.UIComponent;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.controls.SWFLoader;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Context;
    import com.evony.data.GuideStepData;
    import flash.external.ExternalInterface;
    import com.evony.GameConfig;
    import com.evony.util.ResourceLoader;
    import flash.display.Sprite;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class guideLady extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _sound:Sound;
        private var int_step:int;
        private var _textAndSound:TextAndSound;
        private var _3732ui:UIComponent;
        public var type2:String = "guideLady2";
        public var type:String = "guideLady";
        private var _878764393txtLeft:Number = 0;
        private var _loadCount:int;
        private var _guideInfo:Object;
        private var _423675750_needSound:Boolean = true;
        private var _2076436919guideText:TextArea;
        private var conditionNum:int;
        private var _1731433307ladybotom:Number = 30;
        public var b_paly:Boolean = true;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":UIComponent,
                        "id":"ui",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"guideText",
                        "stylesFactory":function ():void
                        {
                            this.backgroundColor = 0;
                            this.borderStyle = "none";
                            this.fontSize = 16;
                            this.color = 0xFFFFFF;
                            this.bottom = "0";
                            this.right = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "selectable":false,
                                "editable":false,
                                "alpha":0.8,
                                "wordWrap":true,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off"
                            });
                        }
                    })]});
            }
        });
        private var _text:SWFLoader = new SWFLoader();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function guideLady()
        {
            mx_internal::_document = this;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.addEventListener("creationComplete", ___guideLady_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            guideLady._watcherSetupUtil = _arg_1;
        }


        public function set guideText(_arg_1:TextArea):void
        {
            var _local_2:Object = this._2076436919guideText;
            if (_local_2 !== _arg_1)
            {
                this._2076436919guideText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "guideText", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:guideLady;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _guideLady_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_guide_guideLadyWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get _needSound():Boolean
        {
            return (this._423675750_needSound);
        }

        [Bindable(event="propertyChange")]
        public function get txtLeft():Number
        {
            return (this._878764393txtLeft);
        }

        private function init():void
        {
            if (Context.getInstance().needUserGuide)
            {
                _text.width = guideText.width;
                _text.height = guideText.height;
                _text.scaleContent = true;
            };
        }

        public function set guideLadyStep(_arg_1:int):void
        {
            var _local_2:String;
            if (_textAndSound)
            {
                _textAndSound.stop();
                _textAndSound = null;
            };
            _textAndSound = new TextAndSound();
            _guideInfo = GuideStepData.getInstance().getGuideInfo(_arg_1);
            guideText.text = GuideStepData.getInstance().getValue(_arg_1);
            _textAndSound.addEventListener(TextAndSound.EVENT_COMPLETE, completeHandle);
            if (ExternalInterface.available)
            {
                ExternalInterface.call("tour_by_flash", Context.getInstance().iPicId, "start2", GuideStep.getInstance().currentStep, "", GameConfig.instance.serverID);
            };
            if (((_arg_1 == 6) && (Context.getInstance().need_speedSound)))
            {
                _local_2 = "fla/guide/Eva18-2.mp3";
                _textAndSound.source(ResourceLoader.getNormalUrl(_guideInfo.textUrl), _local_2);
            }
            else
            {
                _textAndSound.source(ResourceLoader.getNormalUrl(_guideInfo.textUrl), ResourceLoader.getNormalUrl(_guideInfo.mp3Url));
            };
        }

        public function set txtLeft(_arg_1:Number):void
        {
            var _local_2:Object = this._878764393txtLeft;
            if (_local_2 !== _arg_1)
            {
                this._878764393txtLeft = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtLeft", _local_2, _arg_1));
            };
        }

        public function set ui(_arg_1:UIComponent):void
        {
            var _local_2:Object = this._3732ui;
            if (_local_2 !== _arg_1)
            {
                this._3732ui = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ui", _local_2, _arg_1));
            };
        }

        public function set needSound(_arg_1:Boolean):void
        {
            _needSound = _arg_1;
            if (_textAndSound)
            {
                if (_needSound)
                {
                    _textAndSound.playOn();
                }
                else
                {
                    _textAndSound.stop();
                };
            };
        }

        public function set _needSound(_arg_1:Boolean):void
        {
            var _local_2:Object = this._423675750_needSound;
            if (_local_2 !== _arg_1)
            {
                this._423675750_needSound = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_needSound", _local_2, _arg_1));
            };
        }

        public function resourceReady(_arg_1:Object):void
        {
            var _local_2:Sprite = (_arg_1 as Sprite);
            ui.addChild(_local_2);
        }

        private function _guideLady_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ladybotom;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                ui.setStyle("bottom", _arg_1);
            }, "ui.bottom");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.txtLeft;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                guideText.setStyle("left", _arg_1);
            }, "guideText.left");
            result[1] = binding;
            return (result);
        }

        public function set ladybotom(_arg_1:Number):void
        {
            var _local_2:Object = this._1731433307ladybotom;
            if (_local_2 !== _arg_1)
            {
                this._1731433307ladybotom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ladybotom", _local_2, _arg_1));
            };
        }

        private function completeHandle(_arg_1:Event):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("tour_by_flash", Context.getInstance().iPicId, "start3", GuideStep.getInstance().currentStep, "", GameConfig.instance.serverID);
            };
            if (b_paly)
            {
                if (_textAndSound)
                {
                    _textAndSound.play();
                };
                b_paly = false;
            };
        }

        [Bindable(event="propertyChange")]
        public function get guideText():TextArea
        {
            return (this._2076436919guideText);
        }

        [Bindable(event="propertyChange")]
        public function get ui():UIComponent
        {
            return (this._3732ui);
        }

        [Bindable(event="propertyChange")]
        public function get ladybotom():Number
        {
            return (this._1731433307ladybotom);
        }

        private function _guideLady_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ladybotom;
            _local_1 = this.txtLeft;
        }

        public function ___guideLady_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view.module.guide

