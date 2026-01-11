// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.AccountInfo

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.info.Mail.MailsView;
    import autoevony.gui.info.Alliance.AllianceView;
    import autoevony.gui.info.HistoricalHeroes;
    import mx.controls.TabBar;
    import mx.containers.ViewStack;
    import autoevony.gui.info.LegendaryHero;
    import autoevony.gui.info.Items.ItemInfo;
    import mx.containers.HBox;
    import autoevony.gui.info.Stats.StatsView;
    import autoevony.gui.info.Reports.ReportView;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.controls.tabBarClasses.Tab;
    import mx.events.FlexEvent;
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

    public class AccountInfo extends Canvas implements IBindingClient 
    {

        private static var instance:AccountInfo = null;
        private static var createAllFlag:Boolean = false;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _10605819mailInfo:MailsView;
        private var _1606004101allianceInfo:AllianceView;
        private var _1219205682hhInfo:HistoricalHeroes;
        private var _1631638246accountInfoTab:TabBar;
        private var _341646643accountInfoStack:ViewStack;
        private var _1104689078lhInfo:LegendaryHero;
        private var _1177195105itemInfo:ItemInfo;
        public var _AccountInfo_HBox1:HBox;
        private var _1317377314statInfo:StatsView;
        private var _1931047938reportInfo:ReportView;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"all",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "0";
                            this.top = "3";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_AccountInfo_HBox1",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "bottom";
                                        this.borderColor = 2237479;
                                        this.borderStyle = "solid";
                                        this.borderSides = "bottom";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TabBar,
                                                "id":"accountInfoTab",
                                                "stylesFactory":function ():void
                                                {
                                                    this.tabStyleName = "REtabBarAccountTabs";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "dataProvider":"accountInfoStack",
                                                        "styleName":"REtabBar"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"accountInfoStack",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "creationPolicy":"all",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":MailsView,
                                                "id":"mailInfo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Mail"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":AllianceView,
                                                "id":"allianceInfo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Alliance"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":StatsView,
                                                "id":"statInfo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Statistics"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HistoricalHeroes,
                                                "id":"hhInfo",
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderColor = 2237479;
                                                    this.borderThickness = 1;
                                                    this.borderStyle = "solid";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Historic Heroes"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":LegendaryHero,
                                                "id":"lhInfo",
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderColor = 2237479;
                                                    this.borderThickness = 1;
                                                    this.borderStyle = "solid";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Legendary Hero"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ItemInfo,
                                                "id":"itemInfo",
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderColor = 2237479;
                                                    this.borderThickness = 1;
                                                    this.borderStyle = "solid";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Items"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ReportView,
                                                "id":"reportInfo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Reports"});
                                                }
                                            })]
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

        public function AccountInfo()
        {
            mx_internal::_document = this;
            this.creationPolicy = "all";
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___AccountInfo_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AccountInfo._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():AccountInfo
        {
            if (!createAllFlag)
            {
                MainScreen.getInstance().logMsg("Before accessing information in any GUI in the account tab, please make sure you view it first!!!");
                instance.createComponentsFromDescriptors(true);
                createAllFlag = true;
            };
            return (instance);
        }


        [Bindable(event="propertyChange")]
        public function get reportInfo():ReportView
        {
            return (this._1931047938reportInfo);
        }

        public function set reportInfo(_arg_1:ReportView):void
        {
            var _local_2:Object = this._1931047938reportInfo;
            if (_local_2 !== _arg_1)
            {
                this._1931047938reportInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceInfo():AllianceView
        {
            return (this._1606004101allianceInfo);
        }

        public function set allianceInfo(_arg_1:AllianceView):void
        {
            var _local_2:Object = this._1606004101allianceInfo;
            if (_local_2 !== _arg_1)
            {
                this._1606004101allianceInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get mailInfo():MailsView
        {
            return (this._10605819mailInfo);
        }

        public function set mailInfo(_arg_1:MailsView):void
        {
            var _local_2:Object = this._10605819mailInfo;
            if (_local_2 !== _arg_1)
            {
                this._10605819mailInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailInfo", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AccountInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._AccountInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_AccountInfoWatcherSetupUtil");
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
        public function get accountInfoTab():TabBar
        {
            return (this._1631638246accountInfoTab);
        }

        public function set lhInfo(_arg_1:LegendaryHero):void
        {
            var _local_2:Object = this._1104689078lhInfo;
            if (_local_2 !== _arg_1)
            {
                this._1104689078lhInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lhInfo", _local_2, _arg_1));
            };
        }

        public function set hhInfo(_arg_1:HistoricalHeroes):void
        {
            var _local_2:Object = this._1219205682hhInfo;
            if (_local_2 !== _arg_1)
            {
                this._1219205682hhInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hhInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get statInfo():StatsView
        {
            return (this._1317377314statInfo);
        }

        private function init():void
        {
            if (instance == null)
            {
                instance = this;
            };
            createAllFlag = true;
        }

        public function set accountInfoStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._341646643accountInfoStack;
            if (_local_2 !== _arg_1)
            {
                this._341646643accountInfoStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accountInfoStack", _local_2, _arg_1));
            };
        }

        private function _AccountInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Number
            {
                return (((((this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Historic Heroes") || ((this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Legendary Hero")) || ((this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Items")) ? 0 : 1);
            }, function (_arg_1:Number):void
            {
                _AccountInfo_HBox1.setStyle("borderThickness", _arg_1);
            }, "_AccountInfo_HBox1.borderThickness");
            result[0] = binding;
            return (result);
        }

        public function set accountInfoTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._1631638246accountInfoTab;
            if (_local_2 !== _arg_1)
            {
                this._1631638246accountInfoTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accountInfoTab", _local_2, _arg_1));
            };
        }

        public function set itemInfo(_arg_1:ItemInfo):void
        {
            var _local_2:Object = this._1177195105itemInfo;
            if (_local_2 !== _arg_1)
            {
                this._1177195105itemInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemInfo", _local_2, _arg_1));
            };
        }

        public function set statInfo(_arg_1:StatsView):void
        {
            var _local_2:Object = this._1317377314statInfo;
            if (_local_2 !== _arg_1)
            {
                this._1317377314statInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "statInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get accountInfoStack():ViewStack
        {
            return (this._341646643accountInfoStack);
        }

        [Bindable(event="propertyChange")]
        public function get hhInfo():HistoricalHeroes
        {
            return (this._1219205682hhInfo);
        }

        public function toDebugString():String
        {
            return ("fields: mailInfo allianceInfo statInfo hhInfo lhInfo itemInfo reportInfo");
        }

        [Bindable(event="propertyChange")]
        public function get lhInfo():LegendaryHero
        {
            return (this._1104689078lhInfo);
        }

        private function _AccountInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (((((this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Historic Heroes") || ((this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Legendary Hero")) || ((this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Items")) ? 0 : 1);
        }

        public function ___AccountInfo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get itemInfo():ItemInfo
        {
            return (this._1177195105itemInfo);
        }


    }
}//package autoevony.gui

