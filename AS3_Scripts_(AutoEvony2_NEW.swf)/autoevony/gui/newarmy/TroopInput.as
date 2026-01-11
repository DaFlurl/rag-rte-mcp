// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.newarmy.TroopInput

package autoevony.gui.newarmy
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import autoevony.common.Utils;
    import flash.events.MouseEvent;
    import autoevony.gui.controls.themes.ThemeManager;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class TroopInput extends HBox implements IBindingClient 
    {

        private static const WARN_APPEND:String = "The entered value is unsafe and will get 0% heal rate if all die in the battle!";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _903180362tInput:TextInput;
        private var type:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":80,
                    "height":23,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"tInput",
                        "events":{"change":"__tInput_change"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":61,
                                "height":23,
                                "text":"0",
                                "restrict":"0-9",
                                "styleName":"textInput"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 1;
                            this.paddingLeft = 0;
                            this.paddingRight = 0;
                            this.paddingTop = 0;
                            this.paddingBottom = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":19,
                                "height":23,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___TroopInput_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":19,
                                            "height":11,
                                            "focusEnabled":false,
                                            "styleName":"REnumStepUpBtn"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___TroopInput_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":19,
                                            "height":11,
                                            "focusEnabled":false,
                                            "styleName":"REnumStepDnBtn"
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TroopInput()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalGap = 0;
                this.verticalGap = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
            };
            this.width = 80;
            this.height = 23;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", this.___TroopInput_HBox1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopInput._watcherSetupUtil = _arg_1;
        }


        private function _TroopInput_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((parentDocument._applyStygandrsBannerOfTheHorde.selected) ? 7 : 6);
        }

        public function set tInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._903180362tInput;
            if (_local_2 !== _arg_1)
            {
                this._903180362tInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tInput", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TroopInput;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._TroopInput_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_newarmy_TroopInputWatcherSetupUtil");
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

        private function init():void
        {
            this.type = Utils.troopAbrNames.indexOf(this.id.substr(7).toLowerCase());
        }

        public function ___TroopInput_Button1_click(_arg_1:MouseEvent):void
        {
            parentDocument.onMaxBtn(this.tInput);
            this.onChange();
        }

        public function ___TroopInput_Button2_click(_arg_1:MouseEvent):void
        {
            parentDocument.onMinBtn(this.tInput);
            this.onChange();
        }

        private function _TroopInput_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return ((parentDocument._applyStygandrsBannerOfTheHorde.selected) ? 7 : 6);
            }, function (_arg_1:int):void
            {
                tInput.maxChars = _arg_1;
            }, "tInput.maxChars");
            result[0] = binding;
            return (result);
        }

        private function onChange():void
        {
            var _local_1:Number = (int(this.tInput.text) * Utils.TROOP_EXP_VALUES[this.type]);
            if ((Math.floor((_local_1 / 2147483647)) % 2) == 0)
            {
                this.tInput.setStyle("backgroundColor", ("#" + int(ThemeManager.getStyle(("." + this.tInput.styleName), "backgroundColor")).toString(16).toUpperCase()));
                this.tInput.toolTip = ((int(this.tInput.text) != 0) ? (((("(safe) " + "\n-") + Utils.formatNum((((int(this.tInput.text) - Math.floor(((_local_1 % 2147483647) / Utils.TROOP_EXP_VALUES[this.type]))) != 0) ? (Math.floor(((_local_1 % 2147483647) / Utils.TROOP_EXP_VALUES[this.type])) + 1) : 0))) + "  +") + Utils.formatNum(Math.floor(((2147483647 - (_local_1 % 2147483647)) / Utils.TROOP_EXP_VALUES[this.type])))) : "");
            }
            else
            {
                this.tInput.setStyle("backgroundColor", "#CC7776");
                this.tInput.toolTip = ((((("(unsafe)\n-" + Utils.formatNum((Math.floor(((_local_1 % 2147483647) / Utils.TROOP_EXP_VALUES[this.type])) + 1))) + "  +") + Utils.formatNum(Math.floor(((2147483647 - (_local_1 % 2147483647)) / Utils.TROOP_EXP_VALUES[this.type])))) + "\n\n") + WARN_APPEND);
            };
        }

        public function ___TroopInput_HBox1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        public function __tInput_change(_arg_1:Event):void
        {
            parentDocument.onTroopChange((_arg_1.currentTarget as TextInput));
            this.onChange();
        }

        [Bindable(event="propertyChange")]
        public function get tInput():TextInput
        {
            return (this._903180362tInput);
        }


    }
}//package autoevony.gui.newarmy

