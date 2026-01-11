// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.tavern.HireHero

package view.module.tavern
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.DataGrid;
    import view.module.guide.GuideArrow;
    import mx.collections.ArrayCollection;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Image;
    import com.evony.common.beans.HeroBean;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import view.module.guide.GuideStep;
    import com.evony.common.module.CommandResponse;
    import mx.events.FlexEvent;
    import com.evony.common.beans.ItemBean;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
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

    public class HireHero extends Canvas implements IBindingClient 
    {

        public static var instance:HireHero;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1738047212heroLoyalty:TextArea;
        private var _397426866heroPropertyDG:DataGrid;
        private var _2112150940heroSalary:TextArea;
        public var _HireHero_GuideArrow1:GuideArrow;
        private var _95356390dataP:ArrayCollection;
        public var _HireHero_DataGridColumn1:DataGridColumn;
        public var _HireHero_DataGridColumn2:DataGridColumn;
        public var _HireHero_DataGridColumn3:DataGridColumn;
        public var heroobj:Object = null;
        private var _379604938heroInterior:TextArea;
        public var _HireHero_TextArea1:TextArea;
        public var _HireHero_Image1:Image;
        private var _811312001heroMes:HeroBean;
        private var _2010139349heroPower:TextArea;
        public var _HireHero_Label1:Label;
        public var _HireHero_Label2:Label;
        public var _HireHero_Label3:Label;
        public var _HireHero_Label4:Label;
        public var _HireHero_Label5:Label;
        public var _HireHero_Label6:Label;
        public var _HireHero_Label7:Label;
        public var _HireHero_Label8:Label;
        public var bFbHero:Boolean = false;
        private var _1990034853heroWisdom:TextArea;
        private var _2014132310heroLevel:TextArea;
        public var _HireHero_Button1:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":475,
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
                                    "id":"_HireHero_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_HireHero_Image1",
                        "events":{"complete":"___HireHero_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "42";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":109,
                                "height":109
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_HireHero_TextArea1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.top = "158";
                            this.left = "120";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":290,
                                "height":27,
                                "styleName":"labelWithBackGround",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HireHero_Label2",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.textAlign = "right";
                            this.left = "20";
                            this.top = "191";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":24
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HireHero_Label3",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.textAlign = "right";
                            this.top = "161";
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":24
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroLevel",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.left = "120";
                            this.top = "188";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":90,
                                "height":25,
                                "styleName":"labelWithBackGround",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HireHero_Label4",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.textAlign = "right";
                            this.left = "220";
                            this.top = "191";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":24
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroInterior",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.top = "188";
                            this.left = "320";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":90,
                                "height":25,
                                "styleName":"labelWithBackGround",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HireHero_Label5",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.textAlign = "right";
                            this.left = "220";
                            this.top = "221";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":24
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroWisdom",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.top = "218";
                            this.left = "320";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":90,
                                "height":25,
                                "styleName":"labelWithBackGround",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HireHero_Label6",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.textAlign = "right";
                            this.left = "220";
                            this.top = "251";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":24
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroSalary",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.top = "248";
                            this.left = "320";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":90,
                                "height":25,
                                "styleName":"labelWithBackGround",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HireHero_Label7",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.textAlign = "right";
                            this.left = "20";
                            this.top = "221";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":24
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroPower",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.left = "120";
                            this.top = "218";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":90,
                                "height":25,
                                "styleName":"labelWithBackGround",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HireHero_Label8",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.textAlign = "right";
                            this.left = "20";
                            this.top = "251";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":100,
                                "height":24
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"heroLoyalty",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.left = "120";
                            this.top = "248";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":90,
                                "height":25,
                                "styleName":"labelWithBackGround",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"heroPropertyDG",
                        "stylesFactory":function ():void
                        {
                            this.left = "25";
                            this.right = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":284,
                                "height":115,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_HireHero_DataGridColumn1_i(), _HireHero_DataGridColumn2_i(), _HireHero_DataGridColumn3_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_HireHero_Button1",
                        "events":{"click":"___HireHero_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.right = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":25,
                                "styleName":"b75"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___HireHero_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"_HireHero_GuideArrow1",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "30";
                            this.right = "24";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowLGuide"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HireHero()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 475;
            this.addEventListener("creationComplete", ___HireHero_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HireHero._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null, _arg_2:int=0, _arg_3:Boolean=false, _arg_4:Object=null):void
        {
            if (instance == null)
            {
                instance = new (HireHero)();
            };
            instance.bFbHero = _arg_3;
            instance.heroobj = _arg_4;
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, false);
            MinePopupManager.instance.centerPopUp();
            instance.heroMes = HeroBean(_arg_1);
            instance.setCurDataGridValue(_arg_2);
        }


        public function set heroLevel(_arg_1:TextArea):void
        {
            var _local_2:Object = this._2014132310heroLevel;
            if (_local_2 !== _arg_1)
            {
                this._2014132310heroLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroSalary():TextArea
        {
            return (this._2112150940heroSalary);
        }

        public function set heroMes(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._811312001heroMes;
            if (_local_2 !== _arg_1)
            {
                this._811312001heroMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroMes", _local_2, _arg_1));
            };
        }

        private function onHireHero(_arg_1:MouseEvent):void
        {
            if (this.bFbHero)
            {
                if (this.heroobj != null)
                {
                    ActionFactory.getInstance().getHeroCommand().hireFacebookFriendHero(Context.getInstance().getCurCastle().id, heroobj.heroname, heroobj.newname, heroobj.fbid, onHireResponse);
                    PopUpManager.removePopUp(this);
                    return;
                };
            };
            ActionFactory.getInstance().getHeroCommand().hireHero(Context.getInstance().getCurCastle().id, heroMes.name, onHireResponse);
            PopUpManager.removePopUp(this);
        }

        private function _HireHero_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HireHero_DataGridColumn2 = _local_1;
            _local_1.dataField = "needAmount";
            BindingManager.executeBindings(this, "_HireHero_DataGridColumn2", _HireHero_DataGridColumn2);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:HireHero;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HireHero_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_tavern_HireHeroWatcherSetupUtil");
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

        private function onExit(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        private function _HireHero_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("招募英雄");
            _local_1 = heroMes.logoUrl;
            _local_1 = heroMes.name;
            _local_1 = (Lang.msg("等级") + ": ");
            _local_1 = (Lang.msg("名字") + ": ");
            _local_1 = heroMes.level;
            _local_1 = (Lang.msg("内政") + ": ");
            _local_1 = heroMes.management;
            _local_1 = (Lang.msg("智谋") + ": ");
            _local_1 = heroMes.stratagem;
            _local_1 = (Lang.msg("俸禄") + ": ");
            _local_1 = (heroMes.level * 20);
            _local_1 = (Lang.msg("勇武") + ": ");
            _local_1 = heroMes.power;
            _local_1 = (Lang.msg("忠诚") + ": ");
            _local_1 = heroMes.loyalty;
            _local_1 = dataP;
            _local_1 = Lang.msg("招募条件");
            _local_1 = Lang.msg("需要数量");
            _local_1 = Lang.msg("当前数量");
            _local_1 = Lang.msg("招募");
            _local_1 = (GuideStep.getInstance().currentStep == 11);
            _local_1 = (GuideStep.getInstance().currentStep == 11);
        }

        [Bindable(event="propertyChange")]
        public function get heroMes():HeroBean
        {
            return (this._811312001heroMes);
        }

        public function ___HireHero_Button2_click(_arg_1:MouseEvent):void
        {
            onExit(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get heroLevel():TextArea
        {
            return (this._2014132310heroLevel);
        }

        [Bindable(event="propertyChange")]
        public function get heroPower():TextArea
        {
            return (this._2010139349heroPower);
        }

        public function set heroInterior(_arg_1:TextArea):void
        {
            var _local_2:Object = this._379604938heroInterior;
            if (_local_2 !== _arg_1)
            {
                this._379604938heroInterior = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroInterior", _local_2, _arg_1));
            };
        }

        private function _HireHero_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HireHero_DataGridColumn1 = _local_1;
            _local_1.dataField = "needCondition";
            _local_1.width = 150;
            BindingManager.executeBindings(this, "_HireHero_DataGridColumn1", _HireHero_DataGridColumn1);
            return (_local_1);
        }

        private function init():void
        {
            PopUpManager.centerPopUp(this);
        }

        private function _HireHero_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HireHero_DataGridColumn3 = _local_1;
            _local_1.dataField = "curAmount";
            BindingManager.executeBindings(this, "_HireHero_DataGridColumn3", _HireHero_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get heroInterior():TextArea
        {
            return (this._379604938heroInterior);
        }

        private function onHireResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                GuideStep.getInstance().step11();
            };
        }

        public function ___HireHero_Button1_click(_arg_1:MouseEvent):void
        {
            onHireHero(_arg_1);
        }

        public function ___HireHero_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set heroSalary(_arg_1:TextArea):void
        {
            var _local_2:Object = this._2112150940heroSalary;
            if (_local_2 !== _arg_1)
            {
                this._2112150940heroSalary = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroSalary", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroWisdom():TextArea
        {
            return (this._1990034853heroWisdom);
        }

        public function setCurDataGridValue(_arg_1:int):void
        {
            var _local_4:ItemBean;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_4 = Context.getInstance().getPlayerBean().getItems(_local_3);
                if (heroMes.itemId == _local_4.id)
                {
                    _local_2 = _local_4.count;
                };
                _local_3++;
            };
            dataP = new ArrayCollection([{
                "needCondition":Lang.msg("招贤馆空闲"),
                "needAmount":1,
                "curAmount":_arg_1
            }, {
                "needCondition":Lang.msg("消耗黄金"),
                "needAmount":(heroMes.level * 1000),
                "curAmount":Math.floor(Context.getInstance().getCurCastle().resource.gold)
            }, {
                "needCondition":Lang.msg("珠宝需求"),
                "needAmount":heroMes.itemAmount,
                "curAmount":_local_2
            }]);
        }

        private function _HireHero_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招募英雄");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label1.text = _arg_1;
            }, "_HireHero_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroMes.logoUrl);
            }, function (_arg_1:Object):void
            {
                _HireHero_Image1.source = _arg_1;
            }, "_HireHero_Image1.source");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_TextArea1.text = _arg_1;
            }, "_HireHero_TextArea1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("等级") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label2.text = _arg_1;
            }, "_HireHero_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("名字") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label3.text = _arg_1;
            }, "_HireHero_Label3.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.level;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroLevel.text = _arg_1;
            }, "heroLevel.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("内政") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label4.text = _arg_1;
            }, "_HireHero_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.management;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroInterior.text = _arg_1;
            }, "heroInterior.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("智谋") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label5.text = _arg_1;
            }, "_HireHero_Label5.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.stratagem;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroWisdom.text = _arg_1;
            }, "heroWisdom.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("俸禄") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label6.text = _arg_1;
            }, "_HireHero_Label6.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (heroMes.level * 20);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroSalary.text = _arg_1;
            }, "heroSalary.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("勇武") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label7.text = _arg_1;
            }, "_HireHero_Label7.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.power;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroPower.text = _arg_1;
            }, "heroPower.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("忠诚") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Label8.text = _arg_1;
            }, "_HireHero_Label8.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.loyalty;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroLoyalty.text = _arg_1;
            }, "heroLoyalty.text");
            result[15] = binding;
            binding = new Binding(this, function ():Object
            {
                return (dataP);
            }, function (_arg_1:Object):void
            {
                heroPropertyDG.dataProvider = _arg_1;
            }, "heroPropertyDG.dataProvider");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招募条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_DataGridColumn1.headerText = _arg_1;
            }, "_HireHero_DataGridColumn1.headerText");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("需要数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_DataGridColumn2.headerText = _arg_1;
            }, "_HireHero_DataGridColumn2.headerText");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_DataGridColumn3.headerText = _arg_1;
            }, "_HireHero_DataGridColumn3.headerText");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招募");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HireHero_Button1.label = _arg_1;
            }, "_HireHero_Button1.label");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 11);
            }, function (_arg_1:Boolean):void
            {
                _HireHero_GuideArrow1.includeInLayout = _arg_1;
            }, "_HireHero_GuideArrow1.includeInLayout");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 11);
            }, function (_arg_1:Boolean):void
            {
                _HireHero_GuideArrow1.visible = _arg_1;
            }, "_HireHero_GuideArrow1.visible");
            result[22] = binding;
            return (result);
        }

        public function set heroPower(_arg_1:TextArea):void
        {
            var _local_2:Object = this._2010139349heroPower;
            if (_local_2 !== _arg_1)
            {
                this._2010139349heroPower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPower", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataP():ArrayCollection
        {
            return (this._95356390dataP);
        }

        public function set heroLoyalty(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1738047212heroLoyalty;
            if (_local_2 !== _arg_1)
            {
                this._1738047212heroLoyalty = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLoyalty", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroPropertyDG():DataGrid
        {
            return (this._397426866heroPropertyDG);
        }

        public function set heroWisdom(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1990034853heroWisdom;
            if (_local_2 !== _arg_1)
            {
                this._1990034853heroWisdom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroWisdom", _local_2, _arg_1));
            };
        }

        public function ___HireHero_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get heroLoyalty():TextArea
        {
            return (this._1738047212heroLoyalty);
        }

        private function set dataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._95356390dataP;
            if (_local_2 !== _arg_1)
            {
                this._95356390dataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataP", _local_2, _arg_1));
            };
        }

        public function set heroPropertyDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._397426866heroPropertyDG;
            if (_local_2 !== _arg_1)
            {
                this._397426866heroPropertyDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPropertyDG", _local_2, _arg_1));
            };
        }


    }
}//package view.module.tavern

