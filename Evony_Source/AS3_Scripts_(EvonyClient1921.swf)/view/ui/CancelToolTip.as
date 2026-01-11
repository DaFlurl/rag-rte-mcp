// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.CancelToolTip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import com.evony.Lang;
    import view.MainWin;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class CancelToolTip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:CancelToolTip = new (CancelToolTip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CancelToolTip_Text1:Text;
        private var _1017317214descText:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":70,
                    "width":325,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Text,
                        "id":"_CancelToolTip_Text1",
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.top = "5";
                            this.right = "5";
                            this.bottom = "5";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"ParamgraphText1"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CancelToolTip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
            this.height = 70;
            this.width = 325;
        }

        public static function move2Mouse(_arg_1:MouseEvent):void
        {
            instance.moveToMouse(_arg_1);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CancelToolTip._watcherSetupUtil = _arg_1;
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:String, _arg_2:MouseEvent):void
        {
            if (_arg_1 == "Barracks")
            {
                instance.descText = Lang.msg("取消军队提示");
            }
            else
            {
                if (_arg_1 == "Academy")
                {
                    instance.descText = Lang.msg("取消科技提示");
                };
            };
            instance.moveToMouse(_arg_2);
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainWin.instance);
            }
            else
            {
                PopUpManager.bringToFront(instance);
            };
        }


        [Bindable(event="propertyChange")]
        private function get descText():String
        {
            return (this._1017317214descText);
        }

        private function set descText(_arg_1:String):void
        {
            var _local_2:Object = this._1017317214descText;
            if (_local_2 !== _arg_1)
            {
                this._1017317214descText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "descText", _local_2, _arg_1));
            };
        }

        private function _CancelToolTip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = descText;
        }

        override public function initialize():void
        {
            var target:CancelToolTip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CancelToolTip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_CancelToolTipWatcherSetupUtil");
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

        private function _CancelToolTip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = descText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CancelToolTip_Text1.text = _arg_1;
            }, "_CancelToolTip_Text1.text");
            result[0] = binding;
            return (result);
        }


    }
}//package view.ui

