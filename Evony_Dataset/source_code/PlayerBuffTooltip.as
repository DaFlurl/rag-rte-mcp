// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.PlayerBuffTooltip

package view.castle
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.RemainTimeLabel;
    import mx.controls.Text;
    import com.evony.common.beans.BuffBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import com.evony.Context;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
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

    public class PlayerBuffTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:PlayerBuffTooltip = new (PlayerBuffTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _PlayerBuffTooltip_RemainTimeLabel1:RemainTimeLabel;
        public var _PlayerBuffTooltip_Text1:Text;
        private var _3019696bean:BuffBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":230,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "10";
                            this.bottom = "10";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_PlayerBuffTooltip_Text1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "styleName":"ParamgraphText1",
                                            "percentWidth":90
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RemainTimeLabel,
                                    "id":"_PlayerBuffTooltip_RemainTimeLabel1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyValue1",
                                            "x":10,
                                            "percentWidth":90
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

        public function PlayerBuffTooltip()
        {
            mx_internal::_document = this;
            this.width = 230;
            this.styleName = "tooltips";
        }

        public static function mouseMove(_arg_1:MouseEvent):void
        {
            if (instance.isPopUp)
            {
                instance.moveToMouse(_arg_1);
            };
        }

        public static function hide():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:BuffBean, _arg_2:MouseEvent):void
        {
            var _local_3:BuffBean;
            var _local_4:Array;
            if (_arg_1.typeId == "TruceAgreementBuff")
            {
                _local_3 = new BuffBean();
                _local_3.typeId = _arg_1.typeId;
                _local_4 = _arg_1.descName.split("#");
                _local_3.descName = _local_4[0];
                _local_3.endTime = _arg_1.endTime;
                instance.bean = _local_3;
            }
            else
            {
                if (_arg_1.typeId == "playerNewBuff")
                {
                    _arg_1.endTime = (Context.getInstance().getPlayerBean().playerInfo.createrTime + (((7 * 1000) * 3600) * 24));
                }
                else
                {
                    if (((_arg_1.typeId == "HungerBuff") || (_arg_1.typeId == "ServerStopTroopsUpkeep")))
                    {
                        _arg_1.endTime = 0;
                    };
                };
                instance.bean = _arg_1;
            };
            instance.moveToMouse(_arg_2);
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance);
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PlayerBuffTooltip._watcherSetupUtil = _arg_1;
        }


        private function _PlayerBuffTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.bean.descName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerBuffTooltip_Text1.text = _arg_1;
            }, "_PlayerBuffTooltip_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.bean.endTime);
            }, function (_arg_1:Number):void
            {
                _PlayerBuffTooltip_RemainTimeLabel1.remainTime = _arg_1;
            }, "_PlayerBuffTooltip_RemainTimeLabel1.remainTime");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bean.endTime == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _PlayerBuffTooltip_RemainTimeLabel1.visible = _arg_1;
            }, "_PlayerBuffTooltip_RemainTimeLabel1.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bean.endTime == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _PlayerBuffTooltip_RemainTimeLabel1.includeInLayout = _arg_1;
            }, "_PlayerBuffTooltip_RemainTimeLabel1.includeInLayout");
            result[3] = binding;
            return (result);
        }

        private function set bean(_arg_1:BuffBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        private function _PlayerBuffTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.bean.descName;
            _local_1 = this.bean.endTime;
            _local_1 = ((this.bean.endTime == 0) ? false : true);
            _local_1 = ((this.bean.endTime == 0) ? false : true);
        }

        override public function initialize():void
        {
            var target:PlayerBuffTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PlayerBuffTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_PlayerBuffTooltipWatcherSetupUtil");
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
        private function get bean():BuffBean
        {
            return (this._3019696bean);
        }


    }
}//package view.castle

