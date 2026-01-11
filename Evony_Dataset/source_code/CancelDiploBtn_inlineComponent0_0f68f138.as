// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.CancelDiploBtn_inlineComponent0

package autoevony.gui.info.Alliance
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Spacer;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import autoevony.gui.MainScreen;
    import flash.events.MouseEvent;
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

    public class CancelDiploBtn_inlineComponent0 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CancelDiploBtn_inlineComponent0_Button1:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Spacer,
                        "propertiesFactory":function ():Object
                        {
                            return ({"width":3});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_CancelDiploBtn_inlineComponent0_Button1",
                        "events":{"click":"___CancelDiploBtn_inlineComponent0_Button1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Cancel",
                                "styleName":"REwinBtn"
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CancelDiploBtn_inlineComponent0()
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
            };
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CancelDiploBtn_inlineComponent0._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:CancelDiploBtn_inlineComponent0;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._CancelDiploBtn_inlineComponent0_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_CancelDiploBtn_inlineComponent0WatcherSetupUtil");
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

        private function _CancelDiploBtn_inlineComponent0_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.showCancelBtn;
        }

        private function _CancelDiploBtn_inlineComponent0_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (data.showCancelBtn);
            }, function (_arg_1:Boolean):void
            {
                _CancelDiploBtn_inlineComponent0_Button1.visible = _arg_1;
            }, "_CancelDiploBtn_inlineComponent0_Button1.visible");
            result[0] = binding;
            return (result);
        }

        public function ___CancelDiploBtn_inlineComponent0_Button1_click(_arg_1:MouseEvent):void
        {
            MainScreen.getInstance()._accountInfo.allianceInfo.allianceDiplo.cancelRelation(data);
        }


    }
}//package autoevony.gui.info.Alliance

