// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.accouter.AccouterTooltip

package view.module.accouter
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.EquipmentBean;
    import mx.core.UIComponent;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.common.constants.EquipmentTech;
    import com.evony.factory.ItemManager;
    import view.module.workshop.Stars;
    import flash.display.MovieClip;
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

    public class AccouterTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:AccouterTooltip = new (AccouterTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AccouterTooltip_Label1:Label;
        public var _AccouterTooltip_Label2:Label;
        private var _111188pos:String;
        private var _1713445752stoneLev:int;
        private var _2116180394itemEum:EquipmentBean;
        private var _1715338178effectDesc:String;
        private var _3732ui:UIComponent;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "10";
                            this.right = "10";
                            this.top = "10";
                            this.bottom = "10";
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tooltip",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AccouterTooltip_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"contentheader1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":UIComponent,
                                    "id":"ui"
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AccouterTooltip_Label2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var pointArr:Array = [0.4, 0.75, 1, 1.32, 1.74, 2.3, 3.04, 4.01, 5.29, 6.98, 9.22, 12.17, 16.06, 21.2, 27.98];
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AccouterTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AccouterTooltip._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():AccouterTooltip
        {
            return (instance);
        }


        [Bindable(event="propertyChange")]
        public function get pos():String
        {
            return (this._111188pos);
        }

        [Bindable(event="propertyChange")]
        private function get effectDesc():String
        {
            return (this._1715338178effectDesc);
        }

        private function set effectDesc(_arg_1:String):void
        {
            var _local_2:Object = this._1715338178effectDesc;
            if (_local_2 !== _arg_1)
            {
                this._1715338178effectDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "effectDesc", _local_2, _arg_1));
            };
        }

        private function _AccouterTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = pos;
            _local_1 = effectDesc;
        }

        override public function initialize():void
        {
            var target:AccouterTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AccouterTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_accouter_AccouterTooltipWatcherSetupUtil");
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

        public function set itemEums(_arg_1:EquipmentBean):void
        {
            var _local_2:String;
            itemEum = _arg_1;
            var _local_3:int;
            var _local_4:Number = 0;
            stoneLev = itemEum.euipmenttechStarLv;
            if (itemEum.euipmenttechStarLv != 0)
            {
                _local_4 = pointArr[(itemEum.euipmenttechStarLv - 1)];
            };
            while (ui.numChildren > 0)
            {
                ui.removeChildAt(0);
            };
            ui.height = 0;
            switch (itemEum.addAttributeType)
            {
                case EquipmentTech.POLITICS:
                    _local_2 = Lang.msg("内政");
                    break;
                case EquipmentTech.ATTACK:
                    _local_2 = Lang.msg("勇武");
                    break;
                case EquipmentTech.INTELLIGENCE:
                    _local_2 = Lang.msg("智谋");
                    break;
            };
            pos = Lang.msg(ItemManager.heroPosArray[(itemEum.heroPos - 1)]);
            pos = (((pos + "  (Lv.") + itemEum.lv) + ")");
            if (itemEum.heroPos == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L)
            {
                _local_2 = Lang.msg("速度");
            };
            effectDesc = ((("+" + fixNumber((itemEum.addAttribute + _local_4))) + " ") + _local_2);
            if (stoneLev != 0)
            {
                if (Stars.getInstance().ready == false)
                {
                    Stars.getInstance().funArray.push(resourceReady);
                }
                else
                {
                    resourceReady();
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get ui():UIComponent
        {
            return (this._3732ui);
        }

        private function set itemEum(_arg_1:EquipmentBean):void
        {
            var _local_2:Object = this._2116180394itemEum;
            if (_local_2 !== _arg_1)
            {
                this._2116180394itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemEum", _local_2, _arg_1));
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

        public function set pos(_arg_1:String):void
        {
            var _local_2:Object = this._111188pos;
            if (_local_2 !== _arg_1)
            {
                this._111188pos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pos", _local_2, _arg_1));
            };
        }

        private function set stoneLev(_arg_1:int):void
        {
            var _local_2:Object = this._1713445752stoneLev;
            if (_local_2 !== _arg_1)
            {
                this._1713445752stoneLev = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneLev", _local_2, _arg_1));
            };
        }

        private function resourceReady():void
        {
            var _local_1:MovieClip = (new (Stars.getClass(("LV" + stoneLev)))() as MovieClip);
            if (stoneLev <= 8)
            {
                ui.height = 20;
            }
            else
            {
                ui.height = 40;
            };
            ui.width = _local_1.width;
            ui.addChild(_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get stoneLev():int
        {
            return (this._1713445752stoneLev);
        }

        [Bindable(event="propertyChange")]
        private function get itemEum():EquipmentBean
        {
            return (this._2116180394itemEum);
        }

        private function _AccouterTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = pos;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccouterTooltip_Label1.text = _arg_1;
            }, "_AccouterTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = effectDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccouterTooltip_Label2.text = _arg_1;
            }, "_AccouterTooltip_Label2.text");
            result[1] = binding;
            return (result);
        }

        private function fixNumber(_arg_1:Number):String
        {
            var _local_2:String = _arg_1.toFixed(2);
            if (_local_2.indexOf(".00") != -1)
            {
                return (_arg_1.toFixed(0));
            };
            if (_local_2.lastIndexOf("0") == (_local_2.length - 1))
            {
                return (_arg_1.toFixed(1));
            };
            return (_local_2);
        }


    }
}//package view.module.accouter

