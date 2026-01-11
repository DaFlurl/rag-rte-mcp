// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.ColonyAbandonUI

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.ViewStack;
    import com.evony.common.beans.ColonyBean;
    import view.ui.RemainTimeLabel;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.factory.ItemManager;
    import com.evony.MsgDispacther;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.constants.ColonyConstants;
    import flash.events.MouseEvent;
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

    public class ColonyAbandonUI extends Canvas implements IBindingClient 
    {

        public static var ABAMDON_TIME_END:String = "abandonTimeEnd";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1727982925stackView:ViewStack;
        private var _90754191_bean:ColonyBean;
        public var _ColonyAbandonUI_RemainTimeLabel1:RemainTimeLabel;
        private var _84932619quickenUpBtn:Button;
        public var _ColonyAbandonUI_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"stackView",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "right";
                                        this.paddingRight = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":90,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":RemainTimeLabel,
                                                            "id":"_ColonyAbandonUI_RemainTimeLabel1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"quickenUpBtn",
                                                "events":{"click":"__quickenUpBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"quickenUp",
                                                        "width":43
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ColonyAbandonUI_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonyAbandonUI()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyAbandonUI._watcherSetupUtil = _arg_1;
        }


        private function speedUp():void
        {
            AbondonColonyItemWin.show(ItemManager.abondonColonyItemArray, _bean);
        }

        private function endTime():void
        {
            MsgDispacther.getInstance().dispatchEvent(new Event(ColonyAbandonUI.ABAMDON_TIME_END));
        }

        [Bindable(event="propertyChange")]
        public function get quickenUpBtn():Button
        {
            return (this._84932619quickenUpBtn);
        }

        [Bindable(event="propertyChange")]
        public function get stackView():ViewStack
        {
            return (this._1727982925stackView);
        }

        [Bindable(event="propertyChange")]
        private function get _bean():ColonyBean
        {
            return (this._90754191_bean);
        }

        override public function initialize():void
        {
            var target:ColonyAbandonUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyAbandonUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_ColonyAbandonUIWatcherSetupUtil");
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

        public function set quickenUpBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._84932619quickenUpBtn;
            if (_local_2 !== _arg_1)
            {
                this._84932619quickenUpBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "quickenUpBtn", _local_2, _arg_1));
            };
        }

        private function set _bean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._90754191_bean;
            if (_local_2 !== _arg_1)
            {
                this._90754191_bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_bean", _local_2, _arg_1));
            };
        }

        public function set bean(_arg_1:Object):void
        {
            _bean = (_arg_1 as ColonyBean);
            if (_bean.status == ColonyConstants.COLONY_STATUS_ABANDON)
            {
                stackView.selectedIndex = 0;
            }
            else
            {
                stackView.selectedIndex = 1;
            };
        }

        public function set stackView(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1727982925stackView;
            if (_local_2 !== _arg_1)
            {
                this._1727982925stackView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stackView", _local_2, _arg_1));
            };
        }

        private function _ColonyAbandonUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Number
            {
                return (this._bean.endTime);
            }, function (_arg_1:Number):void
            {
                _ColonyAbandonUI_RemainTimeLabel1.remainTime = _arg_1;
            }, "_ColonyAbandonUI_RemainTimeLabel1.remainTime");
            result[0] = binding;
            binding = new Binding(this, function ():Function
            {
                return (endTime);
            }, function (_arg_1:Function):void
            {
                _ColonyAbandonUI_RemainTimeLabel1.callBack = _arg_1;
            }, "_ColonyAbandonUI_RemainTimeLabel1.callBack");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _bean.time;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAbandonUI_Label1.text = _arg_1;
            }, "_ColonyAbandonUI_Label1.text");
            result[2] = binding;
            return (result);
        }

        private function _ColonyAbandonUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._bean.endTime;
            _local_1 = endTime;
            _local_1 = _bean.time;
        }

        public function __quickenUpBtn_click(_arg_1:MouseEvent):void
        {
            speedUp();
        }


    }
}//package view.module.office

