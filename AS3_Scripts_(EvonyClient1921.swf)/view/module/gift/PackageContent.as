// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.gift.PackageContent

package view.module.gift
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.Label;
    import com.evony.common.beans.PackageBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.eum.ItemEum;
    import com.evony.eum.ItemEumDefine;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import com.evony.common.constants.ObjConstants;
    import mx.events.PropertyChangeEvent;
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
    import com.evony.eum.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class PackageContent extends Canvas implements IBindingClient 
    {

        public static var instance:PackageContent = new (PackageContent)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _PackageContent_packageStatusLabel1:packageStatusLabel;
        public var _PackageContent_TextArea1:TextArea;
        public var _PackageContent_TextArea2:TextArea;
        private var _849114606giftList:String;
        public var _PackageContent_Label1:Label;
        public var _PackageContent_Label2:Label;
        public var _PackageContent_Label4:Label;
        public var _PackageContent_Label5:Label;
        public var _PackageContent_Label6:Label;
        public var _PackageContent_Label7:Label;
        public var _PackageContent_Label3:Label;
        private var _995427235packageContentBean:PackageBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":378,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_PackageContent_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":5,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.top = "43";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "height":140,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_PackageContent_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "y":8
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":204,
                                            "y":33,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PackageContent_Label3"
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PackageContent_Label4"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":21,
                                            "y":33,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_PackageContent_Label5"
                                            }), new UIComponentDescriptor({
                                                "type":packageStatusLabel,
                                                "id":"_PackageContent_packageStatusLabel1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 16072996;
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_PackageContent_Label6",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "y":57
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_PackageContent_TextArea1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.top = "77";
                                        this.right = "20";
                                        this.bottom = "5";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.bottom = "15";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "height":187,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_PackageContent_Label7",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "y":8
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_PackageContent_TextArea2",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.top = "30";
                                        this.right = "10";
                                        this.bottom = "5";
                                        this.color = 0x38AA00;
                                        this.fontWeight = "bold";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___PackageContent_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
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

        public function PackageContent()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 378;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PackageContent._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object):void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.packageContentBean = (_arg_1 as PackageBean);
            instance.reFresh();
        }


        private function submitHandel():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function isSpecialPacket(_arg_1:String):Boolean
        {
            var _local_3:ItemEum;
            var _local_2:Array = ItemEumDefine.getPacketItemEumArray();
            for each (_local_3 in _local_2)
            {
                if (_arg_1.indexOf(_local_3.id) >= 0)
                {
                    return (true);
                };
            };
            return (false);
        }

        override public function initialize():void
        {
            var target:PackageContent;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PackageContent_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_gift_PackageContentWatcherSetupUtil");
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

        public function ___PackageContent_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function _PackageContent_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("礼包");
            _local_1 = this.packageContentBean.packageName;
            _local_1 = Lang.msg("获得时间");
            _local_1 = (this.packageContentBean.status == ObjConstants.PACKAGE_STATUS_HAD_GOT);
            _local_1 = this.packageContentBean.claimedTime;
            _local_1 = (this.packageContentBean.status == ObjConstants.PACKAGE_STATUS_HAD_GOT);
            _local_1 = Lang.msg("礼包状态");
            _local_1 = ((this.packageContentBean.status == ObjConstants.PACKAGE_STATUS_AVAIBLE) ? 0 : this.packageContentBean.status);
            _local_1 = Lang.msg("领取条件");
            _local_1 = this.packageContentBean.desc;
            _local_1 = Lang.msg("礼包内容");
            _local_1 = this.giftList;
        }

        private function _PackageContent_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼包");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_Label1.text = _arg_1;
            }, "_PackageContent_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.packageContentBean.packageName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_Label2.text = _arg_1;
            }, "_PackageContent_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("获得时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_Label3.text = _arg_1;
            }, "_PackageContent_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.packageContentBean.status == ObjConstants.PACKAGE_STATUS_HAD_GOT);
            }, function (_arg_1:Boolean):void
            {
                _PackageContent_Label3.visible = _arg_1;
            }, "_PackageContent_Label3.visible");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.packageContentBean.claimedTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_Label4.text = _arg_1;
            }, "_PackageContent_Label4.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.packageContentBean.status == ObjConstants.PACKAGE_STATUS_HAD_GOT);
            }, function (_arg_1:Boolean):void
            {
                _PackageContent_Label4.visible = _arg_1;
            }, "_PackageContent_Label4.visible");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼包状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_Label5.text = _arg_1;
            }, "_PackageContent_Label5.text");
            result[6] = binding;
            binding = new Binding(this, function ():int
            {
                return ((this.packageContentBean.status == ObjConstants.PACKAGE_STATUS_AVAIBLE) ? 0 : this.packageContentBean.status);
            }, function (_arg_1:int):void
            {
                _PackageContent_packageStatusLabel1.status = _arg_1;
            }, "_PackageContent_packageStatusLabel1.status");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("领取条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_Label6.text = _arg_1;
            }, "_PackageContent_Label6.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.packageContentBean.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_TextArea1.text = _arg_1;
            }, "_PackageContent_TextArea1.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼包内容");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_Label7.text = _arg_1;
            }, "_PackageContent_Label7.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.giftList;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PackageContent_TextArea2.text = _arg_1;
            }, "_PackageContent_TextArea2.text");
            result[11] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get packageContentBean():PackageBean
        {
            return (this._995427235packageContentBean);
        }

        private function setContent():void
        {
            var _local_2:int;
            var _local_1:* = "";
            if (((this.packageContentBean.minMedal > 0) && (this.packageContentBean.maxMedal > 0)))
            {
                if (this.packageContentBean.minMedal == this.packageContentBean.maxMedal)
                {
                    _local_1 = (_local_1 + (("This package contains " + this.packageContentBean.minMedal) + " game coins."));
                }
                else
                {
                    _local_1 = (_local_1 + (((("This package contains " + this.packageContentBean.minMedal) + " to ") + this.packageContentBean.maxMedal) + " cents game coins."));
                };
            };
            while (_local_2 < this.packageContentBean.itemListArray.length)
            {
                _local_1 = (_local_1 + (this.packageContentBean.itemListArray[_local_2].name + "*"));
                if (this.packageContentBean.itemListArray[_local_2].minCount == this.packageContentBean.itemListArray[_local_2].maxCount)
                {
                    if (this.packageContentBean.itemListArray[_local_2].minCount == 0)
                    {
                        _local_1 = (_local_1 + (this.packageContentBean.itemListArray[_local_2].count + "   "));
                    }
                    else
                    {
                        _local_1 = (_local_1 + (this.packageContentBean.itemListArray[_local_2].minCount + "   "));
                    };
                }
                else
                {
                    _local_1 = (_local_1 + (((("(" + this.packageContentBean.itemListArray[_local_2].minCount) + " to ") + this.packageContentBean.itemListArray[_local_2].maxCount) + ")   "));
                };
                _local_2++;
            };
            this.giftList = _local_1;
            if (((((((((((this.packageContentBean.packageName.indexOf("Special Christmas Chest") >= 0) || (this.packageContentBean.packageName.indexOf("Special New Year Chest") >= 0)) || (this.packageContentBean.packageName.indexOf("Special Easter Chest") >= 0)) || (this.packageContentBean.packageName.indexOf("Special Evony Happiness Chest") >= 0)) || (this.packageContentBean.packageName.indexOf("Halloween Chest O'Treats") >= 0)) || (this.packageContentBean.packageName.indexOf("Special Thanksgiving Package") >= 0)) || (this.packageContentBean.packageName.indexOf("Secret Santa Chest") >= 0)) || (this.packageContentBean.packageName.indexOf("Valentine's Day Chest") >= 0)) || (this.packageContentBean.packageName.indexOf("St Patrick’s Day") >= 0)) || (this.packageContentBean.packageName.indexOf("Special Easter Chest A") >= 0)))
            {
                this.giftList = "Includes: Chest A (Freedom Medal, Justice Medal, Nation Medal, Michelangelo's Script, Plowshares, Arch Saw, Quarrying Tools, Blower, War Ensign, Excalibur, The Wealth of Nations, Amulet) or Chest B (Primary Guidelines, Intermediate Guidelines, Hero Hunting, Merchant Fleet, Plowshares, Double Saw, Quarrying Tools, Blower, Michelangelo's Script, Tax Policy, The Wealth of Nations) or Chest C (Excalibur, War Horn, Corselect, Truce Agreement, War Ensign, Adv City Teleporter, Michelangelo's Script).";
            };
            if (this.packageContentBean.packageName.indexOf("Battlechest of Christmas") >= 0)
            {
                this.giftList = "Sleigh-full of Goddies*1 or Elf Assault Kit*1 or Kringle's Paired Blades*1 or Rudolph's Battle Gear*1 or Santa's Christmas Eve Showdown*1";
            }
            else
            {
                if (this.packageContentBean.packageName.indexOf("Casanova's Package") >= 0)
                {
                    this.giftList = "Writings from Casanova*1 or Box of Candies*1 or Flowers and a Card*1 or Crown of Flowers*1 or Gilded Jewelry Box*1";
                };
            };
            if (isSpecialPacket(this.packageContentBean.packageName))
            {
                this.giftList = "Includes: Chest A (Freedom Medal, Justice Medal, Nation Medal, Michelangelo's Script, Plowshares, Arch Saw, Quarrying Tools, Blower, War Ensign, Excalibur, The Wealth of Nations, Amulet) or Chest B (Primary Guidelines, Intermediate Guidelines, Hero Hunting, Merchant Fleet, Plowshares, Double Saw, Quarrying Tools, Blower, Michelangelo's Script, Tax Policy, The Wealth of Nations) or Chest C (Excalibur, War Horn, Corselect, Truce Agreement, War Ensign, Adv City Teleporter, Michelangelo's Script).";
            }
            else
            {
                if (isSpecialPacket2(this.packageContentBean.packageName))
                {
                    this.giftList = "Includes: Chest A (War Ensign, War Horn, Aries Amulet) or Chest B (Epitome of Military Science, Adv City Teleporter, Wealth of Nations,  Archimedes' Note) or Chest C (Excalibur, On War, Ivory Horn, Ultra Corselet, Justice Medal)";
                }
                else
                {
                    if (this.packageContentBean.packageName.indexOf("Easter Chest") == 0)
                    {
                        this.giftList = "Includes: Easter Bunny’s Bounty or Easter Basket or Chocolate Bunny or Painted Easter Egg or Easter Chick.";
                    };
                };
            };
        }

        private function reFresh():void
        {
            this.setContent();
        }

        private function set packageContentBean(_arg_1:PackageBean):void
        {
            var _local_2:Object = this._995427235packageContentBean;
            if (_local_2 !== _arg_1)
            {
                this._995427235packageContentBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "packageContentBean", _local_2, _arg_1));
            };
        }

        public function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function set giftList(_arg_1:String):void
        {
            var _local_2:Object = this._849114606giftList;
            if (_local_2 !== _arg_1)
            {
                this._849114606giftList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "giftList", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get giftList():String
        {
            return (this._849114606giftList);
        }

        private function cancelHandel():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function isSpecialPacket2(_arg_1:String):Boolean
        {
            var _local_3:ItemEum;
            var _local_2:Array = ItemEumDefine.getPacketItemEumArray2();
            for each (_local_3 in _local_2)
            {
                if (_arg_1.indexOf(_local_3.id) >= 0)
                {
                    return (true);
                };
            };
            return (false);
        }


    }
}//package view.module.gift

