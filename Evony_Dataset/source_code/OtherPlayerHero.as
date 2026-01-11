// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.OtherPlayerHero

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import com.evony.common.beans.HeroBean;
    import view.module.accouter.AccoutContainer;
    import mx.controls.Image;
    import mx.collections.ArrayCollection;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import mx.events.PropertyChangeEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.client.response.ResponseDispatcher;
    import view.module.accouter.ControlUI;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.common.constants.EquipmentTech;
    import com.evony.common.beans.EquipmentBean;
    import mx.events.FlexEvent;
    import flash.display.Bitmap;
    import mx.controls.dataGridClasses.DataGridItemRenderer;
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

    public class OtherPlayerHero extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1220754132hero_1:OtherPlayerHeroItem;
        public var _OtherPlayerHero_Label1:Label;
        private var _1315418018exitBtn:Button;
        private var curCallAlert:String = "";
        private var _99168120hero2:HeroBean;
        private var _733258334accoutCont10:AccoutContainer;
        private var _733258336accoutCont12:AccoutContainer;
        private var _733258304accoutCont01:AccoutContainer;
        private var _733258306accoutCont03:AccoutContainer;
        private var _286627347accoutCont12_2:AccoutContainer;
        private var _733258308accoutCont05:AccoutContainer;
        private var _733258311accoutCont08:AccoutContainer;
        private var _286603322accoutCont08_2:AccoutContainer;
        private var _99168119hero1:HeroBean;
        private var _286627348accoutCont12_3:AccoutContainer;
        private var _1220754130hero_3:OtherPlayerHeroItem;
        public var _OtherPlayerHero_Image2:Image;
        private var _811312001heroMes:HeroBean;
        private var _733258335accoutCont11:AccoutContainer;
        private var _733258305accoutCont02:AccoutContainer;
        private var _99168121hero3:HeroBean;
        private var _286604283accoutCont09_2:AccoutContainer;
        private var _733258307accoutCont04:AccoutContainer;
        private var _733258309accoutCont06:AccoutContainer;
        private var _1220754131hero_2:OtherPlayerHeroItem;
        private var _1101236847remainPoints:int;
        private var _619157576heroList:ArrayCollection;
        private var _733258310accoutCont07:AccoutContainer;
        private var _733258312accoutCont09:AccoutContainer;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":820,
                    "height":530,
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
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_OtherPlayerHero_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":8,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "62";
                            this.left = "33";
                            this.verticalGap = 30;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":OtherPlayerHeroItem,
                                    "id":"hero_1",
                                    "events":{"click":"__hero_1_click"}
                                }), new UIComponentDescriptor({
                                    "type":OtherPlayerHeroItem,
                                    "id":"hero_2",
                                    "events":{"click":"__hero_2_click"}
                                }), new UIComponentDescriptor({
                                    "type":OtherPlayerHeroItem,
                                    "id":"hero_3",
                                    "events":{"click":"__hero_3_click"}
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":470,
                                "y":60,
                                "width":320,
                                "height":445,
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "events":{"complete":"___OtherPlayerHero_Image1_complete"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "source":"images/EmbedImages/playInfo/armsbg.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_OtherPlayerHero_Image2",
                                    "events":{"complete":"___OtherPlayerHero_Image2_complete"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":47,
                                            "y":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont01",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":85,
                                            "y":17,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont04",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":16,
                                            "y":60,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont12",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":16,
                                            "y":109,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont12_2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":16,
                                            "y":156,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont12_3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":16,
                                            "y":203,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont09",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":16,
                                            "y":250,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont08",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":16,
                                            "y":297,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont11",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":16,
                                            "y":373,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont02",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":206,
                                            "y":17,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont03",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":0x0101,
                                            "y":60,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont05",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":0x0101,
                                            "y":109,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont07",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":0x0101,
                                            "y":156,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont06",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":0x0101,
                                            "y":203,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont09_2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":0x0101,
                                            "y":250,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont08_2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":0x0101,
                                            "y":297,
                                            "showPanle":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AccoutContainer,
                                    "id":"accoutCont10",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":40,
                                            "x":0x0101,
                                            "y":343,
                                            "showPanle":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"exitBtn",
                        "events":{"click":"__exitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function OtherPlayerHero()
        {
            mx_internal::_document = this;
            this.width = 820;
            this.height = 530;
            this.addEventListener("creationComplete", ___OtherPlayerHero_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            OtherPlayerHero._watcherSetupUtil = _arg_1;
        }


        public function destroy():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont09_2():AccoutContainer
        {
            return (this._286604283accoutCont09_2);
        }

        public function set accoutCont09_2(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._286604283accoutCont09_2;
            if (_local_2 !== _arg_1)
            {
                this._286604283accoutCont09_2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont09_2", _local_2, _arg_1));
            };
        }

        private function set hero2(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._99168120hero2;
            if (_local_2 !== _arg_1)
            {
                this._99168120hero2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero2", _local_2, _arg_1));
            };
        }

        private function set heroMes(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._811312001heroMes;
            if (_local_2 !== _arg_1)
            {
                this._811312001heroMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroMes", _local_2, _arg_1));
            };
        }

        public function ___OtherPlayerHero_Image2_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function init():void
        {
            PopUpManager.centerPopUp(this);
            ResponseDispatcher.getInstance().addEventListener(ControlUI.EQUIPMENTUPDATE_EVENT, equipmengupdate);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont12_2():AccoutContainer
        {
            return (this._286627347accoutCont12_2);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont12_3():AccoutContainer
        {
            return (this._286627348accoutCont12_3);
        }

        public function __hero_3_click(_arg_1:MouseEvent):void
        {
            changeHero(_arg_1);
        }

        public function set accoutCont12_2(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._286627347accoutCont12_2;
            if (_local_2 !== _arg_1)
            {
                this._286627347accoutCont12_2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont12_2", _local_2, _arg_1));
            };
        }

        public function set accoutCont12_3(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._286627348accoutCont12_3;
            if (_local_2 !== _arg_1)
            {
                this._286627348accoutCont12_3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont12_3", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get hero_2():OtherPlayerHeroItem
        {
            return (this._1220754131hero_2);
        }

        [Bindable(event="propertyChange")]
        public function get hero_3():OtherPlayerHeroItem
        {
            return (this._1220754130hero_3);
        }

        public function setHeroList(_arg_1:ArrayCollection):void
        {
            this.heroList = _arg_1;
            this.heroMes = null;
            if (_arg_1.length > 0)
            {
                this.heroMes = this.heroList[0];
                this.hero1 = heroList[0];
                hero_1.setStyle("backgroundColor", 16508084);
                if (heroList.length >= 2)
                {
                    this.hero2 = heroList[1];
                }
                else
                {
                    this.hero2 = null;
                };
                if (heroList.length >= 3)
                {
                    this.hero3 = heroList[2];
                }
                else
                {
                    this.hero3 = null;
                };
            };
            setAccountBean();
        }

        [Bindable(event="propertyChange")]
        public function get hero_1():OtherPlayerHeroItem
        {
            return (this._1220754132hero_1);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont01():AccoutContainer
        {
            return (this._733258304accoutCont01);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont02():AccoutContainer
        {
            return (this._733258305accoutCont02);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont03():AccoutContainer
        {
            return (this._733258306accoutCont03);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont04():AccoutContainer
        {
            return (this._733258307accoutCont04);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont05():AccoutContainer
        {
            return (this._733258308accoutCont05);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont06():AccoutContainer
        {
            return (this._733258309accoutCont06);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont07():AccoutContainer
        {
            return (this._733258310accoutCont07);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont08():AccoutContainer
        {
            return (this._733258311accoutCont08);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont08_2():AccoutContainer
        {
            return (this._286603322accoutCont08_2);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont09():AccoutContainer
        {
            return (this._733258312accoutCont09);
        }

        public function set hero_1(_arg_1:OtherPlayerHeroItem):void
        {
            var _local_2:Object = this._1220754132hero_1;
            if (_local_2 !== _arg_1)
            {
                this._1220754132hero_1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero_1", _local_2, _arg_1));
            };
        }

        public function set hero_3(_arg_1:OtherPlayerHeroItem):void
        {
            var _local_2:Object = this._1220754130hero_3;
            if (_local_2 !== _arg_1)
            {
                this._1220754130hero_3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero_3", _local_2, _arg_1));
            };
        }

        public function set hero_2(_arg_1:OtherPlayerHeroItem):void
        {
            var _local_2:Object = this._1220754131hero_2;
            if (_local_2 !== _arg_1)
            {
                this._1220754131hero_2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero_2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont10():AccoutContainer
        {
            return (this._733258334accoutCont10);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont11():AccoutContainer
        {
            return (this._733258335accoutCont11);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont12():AccoutContainer
        {
            return (this._733258336accoutCont12);
        }

        [Bindable(event="propertyChange")]
        public function get exitBtn():Button
        {
            return (this._1315418018exitBtn);
        }

        [Bindable(event="propertyChange")]
        private function get remainPoints():int
        {
            return (this._1101236847remainPoints);
        }

        private function set heroList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._619157576heroList;
            if (_local_2 !== _arg_1)
            {
                this._619157576heroList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroList", _local_2, _arg_1));
            };
        }

        public function set accoutCont08_2(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._286603322accoutCont08_2;
            if (_local_2 !== _arg_1)
            {
                this._286603322accoutCont08_2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont08_2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get hero1():HeroBean
        {
            return (this._99168119hero1);
        }

        [Bindable(event="propertyChange")]
        private function get hero2():HeroBean
        {
            return (this._99168120hero2);
        }

        [Bindable(event="propertyChange")]
        private function get hero3():HeroBean
        {
            return (this._99168121hero3);
        }

        public function set accoutCont01(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258304accoutCont01;
            if (_local_2 !== _arg_1)
            {
                this._733258304accoutCont01 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont01", _local_2, _arg_1));
            };
        }

        public function set accoutCont02(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258305accoutCont02;
            if (_local_2 !== _arg_1)
            {
                this._733258305accoutCont02 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont02", _local_2, _arg_1));
            };
        }

        public function set _heroMes(_arg_1:HeroBean):void
        {
            if (_arg_1 != null)
            {
                heroMes = _arg_1;
            }
            else
            {
                heroMes = null;
            };
            setAccountBean();
        }

        public function set accoutCont04(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258307accoutCont04;
            if (_local_2 !== _arg_1)
            {
                this._733258307accoutCont04 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont04", _local_2, _arg_1));
            };
        }

        public function __exitBtn_click(_arg_1:MouseEvent):void
        {
            onExit();
        }

        public function set accoutCont05(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258308accoutCont05;
            if (_local_2 !== _arg_1)
            {
                this._733258308accoutCont05 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont05", _local_2, _arg_1));
            };
        }

        private function equipmengupdate(_arg_1:Event):void
        {
            this.setAccountBean();
        }

        public function set accoutCont03(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258306accoutCont03;
            if (_local_2 !== _arg_1)
            {
                this._733258306accoutCont03 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont03", _local_2, _arg_1));
            };
        }

        public function set accoutCont07(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258310accoutCont07;
            if (_local_2 !== _arg_1)
            {
                this._733258310accoutCont07 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont07", _local_2, _arg_1));
            };
        }

        public function set accoutCont08(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258311accoutCont08;
            if (_local_2 !== _arg_1)
            {
                this._733258311accoutCont08 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont08", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:OtherPlayerHero;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _OtherPlayerHero_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_OtherPlayerHeroWatcherSetupUtil");
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

        public function set accoutCont06(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258309accoutCont06;
            if (_local_2 !== _arg_1)
            {
                this._733258309accoutCont06 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont06", _local_2, _arg_1));
            };
        }

        public function __hero_1_click(_arg_1:MouseEvent):void
        {
            changeHero(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get heroMes():HeroBean
        {
            return (this._811312001heroMes);
        }

        private function onExit():void
        {
            PopUpManager.removePopUp(this);
        }

        public function set accoutCont09(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258312accoutCont09;
            if (_local_2 !== _arg_1)
            {
                this._733258312accoutCont09 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont09", _local_2, _arg_1));
            };
        }

        private function _OtherPlayerHero_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("英雄属性");
            _local_1 = hero1;
            _local_1 = (this.heroList.length >= 1);
            _local_1 = (this.heroList.length >= 1);
            _local_1 = hero2;
            _local_1 = (this.heroList.length >= 2);
            _local_1 = (this.heroList.length >= 2);
            _local_1 = hero3;
            _local_1 = (this.heroList.length >= 3);
            _local_1 = (this.heroList.length >= 3);
            _local_1 = ((heroMes.sex) ? "images/EmbedImages/playInfo/heroMan.png" : "images/EmbedImages/playInfo/heroWoman.png");
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_HEAD;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_CHEST;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_WEAPON_L;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_SHIELD_L;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_LEG_L;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_RING_L;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_MOUNT_L;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_NECKLACE;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_SHOULDERS;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_BACK;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_WRIST;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_WAIST;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_RING_R;
            _local_1 = EquipmentTech.EQUIPMENT_SLOT_FEET;
        }

        private function setAccountBean():void
        {
            var _local_2:int;
            var _local_3:EquipmentBean;
            if (this.heroMes == null)
            {
                return;
            };
            var _local_1:Array = [accoutCont01, accoutCont02, accoutCont03, accoutCont04, accoutCont05, accoutCont06, accoutCont07, accoutCont08, accoutCont08_2, accoutCont09, accoutCont09_2, accoutCont10, accoutCont11, accoutCont12, accoutCont12_2, accoutCont12_3];
            while (_local_2 < _local_1.length)
            {
                for each (_local_3 in this.heroMes.equipmentbeanArray)
                {
                    if (_local_3.heroPos == _local_1[_local_2].posId)
                    {
                        _local_1[_local_2].itemBean = _local_3;
                        _local_1[_local_2].setHeroId(heroMes.id);
                    };
                };
                _local_2++;
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroList():ArrayCollection
        {
            return (this._619157576heroList);
        }

        public function set accoutCont10(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258334accoutCont10;
            if (_local_2 !== _arg_1)
            {
                this._733258334accoutCont10 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont10", _local_2, _arg_1));
            };
        }

        public function set accoutCont12(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258336accoutCont12;
            if (_local_2 !== _arg_1)
            {
                this._733258336accoutCont12 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont12", _local_2, _arg_1));
            };
        }

        public function ___OtherPlayerHero_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function changeHero(_arg_1:MouseEvent):void
        {
            switch (_arg_1.currentTarget.name)
            {
                case "hero_1":
                    hero_1.setStyle("backgroundColor", 16508084);
                    hero_2.setStyle("backgroundColor", 11590641);
                    hero_3.setStyle("backgroundColor", 11590641);
                    heroMes = heroList[0];
                    break;
                case "hero_2":
                    hero_2.setStyle("backgroundColor", 16508084);
                    hero_1.setStyle("backgroundColor", 11590641);
                    hero_3.setStyle("backgroundColor", 11590641);
                    heroMes = heroList[1];
                    break;
                case "hero_3":
                    hero_3.setStyle("backgroundColor", 16508084);
                    hero_1.setStyle("backgroundColor", 11590641);
                    hero_2.setStyle("backgroundColor", 11590641);
                    heroMes = heroList[2];
                    break;
            };
            setAccountBean();
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function set exitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1315418018exitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1315418018exitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exitBtn", _local_2, _arg_1));
            };
        }

        private function onHeroSelect(_arg_1:MouseEvent):void
        {
            if (((_arg_1.target is DataGridItemRenderer) && (_arg_1.target.data is HeroBean)))
            {
                _heroMes = (_arg_1.target.data as HeroBean);
            };
            setAccountBean();
        }

        public function __hero_2_click(_arg_1:MouseEvent):void
        {
            changeHero(_arg_1);
        }

        private function set remainPoints(_arg_1:int):void
        {
            var _local_2:Object = this._1101236847remainPoints;
            if (_local_2 !== _arg_1)
            {
                this._1101236847remainPoints = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainPoints", _local_2, _arg_1));
            };
        }

        private function _OtherPlayerHero_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("英雄属性");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _OtherPlayerHero_Label1.text = _arg_1;
            }, "_OtherPlayerHero_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():HeroBean
            {
                return (hero1);
            }, function (_arg_1:HeroBean):void
            {
                hero_1.heroMes = _arg_1;
            }, "hero_1.heroMes");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.heroList.length >= 1);
            }, function (_arg_1:Boolean):void
            {
                hero_1.includeInLayout = _arg_1;
            }, "hero_1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.heroList.length >= 1);
            }, function (_arg_1:Boolean):void
            {
                hero_1.visible = _arg_1;
            }, "hero_1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():HeroBean
            {
                return (hero2);
            }, function (_arg_1:HeroBean):void
            {
                hero_2.heroMes = _arg_1;
            }, "hero_2.heroMes");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.heroList.length >= 2);
            }, function (_arg_1:Boolean):void
            {
                hero_2.includeInLayout = _arg_1;
            }, "hero_2.includeInLayout");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.heroList.length >= 2);
            }, function (_arg_1:Boolean):void
            {
                hero_2.visible = _arg_1;
            }, "hero_2.visible");
            result[6] = binding;
            binding = new Binding(this, function ():HeroBean
            {
                return (hero3);
            }, function (_arg_1:HeroBean):void
            {
                hero_3.heroMes = _arg_1;
            }, "hero_3.heroMes");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.heroList.length >= 3);
            }, function (_arg_1:Boolean):void
            {
                hero_3.includeInLayout = _arg_1;
            }, "hero_3.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.heroList.length >= 3);
            }, function (_arg_1:Boolean):void
            {
                hero_3.visible = _arg_1;
            }, "hero_3.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((heroMes.sex) ? "images/EmbedImages/playInfo/heroMan.png" : "images/EmbedImages/playInfo/heroWoman.png");
            }, function (_arg_1:Object):void
            {
                _OtherPlayerHero_Image2.source = _arg_1;
            }, "_OtherPlayerHero_Image2.source");
            result[10] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_HEAD);
            }, function (_arg_1:int):void
            {
                accoutCont01.posId = _arg_1;
            }, "accoutCont01.posId");
            result[11] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_CHEST);
            }, function (_arg_1:int):void
            {
                accoutCont04.posId = _arg_1;
            }, "accoutCont04.posId");
            result[12] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_WEAPON_L);
            }, function (_arg_1:int):void
            {
                accoutCont12.posId = _arg_1;
            }, "accoutCont12.posId");
            result[13] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_SHIELD_L);
            }, function (_arg_1:int):void
            {
                accoutCont12_2.posId = _arg_1;
            }, "accoutCont12_2.posId");
            result[14] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_LEG_L);
            }, function (_arg_1:int):void
            {
                accoutCont12_3.posId = _arg_1;
            }, "accoutCont12_3.posId");
            result[15] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L);
            }, function (_arg_1:int):void
            {
                accoutCont09.posId = _arg_1;
            }, "accoutCont09.posId");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_RING_L);
            }, function (_arg_1:int):void
            {
                accoutCont08.posId = _arg_1;
            }, "accoutCont08.posId");
            result[17] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            }, function (_arg_1:int):void
            {
                accoutCont11.posId = _arg_1;
            }, "accoutCont11.posId");
            result[18] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_NECKLACE);
            }, function (_arg_1:int):void
            {
                accoutCont02.posId = _arg_1;
            }, "accoutCont02.posId");
            result[19] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_SHOULDERS);
            }, function (_arg_1:int):void
            {
                accoutCont03.posId = _arg_1;
            }, "accoutCont03.posId");
            result[20] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_BACK);
            }, function (_arg_1:int):void
            {
                accoutCont05.posId = _arg_1;
            }, "accoutCont05.posId");
            result[21] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_WRIST);
            }, function (_arg_1:int):void
            {
                accoutCont07.posId = _arg_1;
            }, "accoutCont07.posId");
            result[22] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_WAIST);
            }, function (_arg_1:int):void
            {
                accoutCont06.posId = _arg_1;
            }, "accoutCont06.posId");
            result[23] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R);
            }, function (_arg_1:int):void
            {
                accoutCont09_2.posId = _arg_1;
            }, "accoutCont09_2.posId");
            result[24] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_RING_R);
            }, function (_arg_1:int):void
            {
                accoutCont08_2.posId = _arg_1;
            }, "accoutCont08_2.posId");
            result[25] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_FEET);
            }, function (_arg_1:int):void
            {
                accoutCont10.posId = _arg_1;
            }, "accoutCont10.posId");
            result[26] = binding;
            return (result);
        }

        private function set hero1(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._99168119hero1;
            if (_local_2 !== _arg_1)
            {
                this._99168119hero1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero1", _local_2, _arg_1));
            };
        }

        public function ___OtherPlayerHero_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function set hero3(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._99168121hero3;
            if (_local_2 !== _arg_1)
            {
                this._99168121hero3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hero3", _local_2, _arg_1));
            };
        }

        public function set accoutCont11(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258335accoutCont11;
            if (_local_2 !== _arg_1)
            {
                this._733258335accoutCont11 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont11", _local_2, _arg_1));
            };
        }


    }
}//package view.ui

