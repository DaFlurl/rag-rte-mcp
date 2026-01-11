// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.AutoHealReportDetail

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.core.UIComponentDescriptor;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import view.module.trainningField.TroopTypeUI;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import mx.utils.ObjectProxy;
    import com.evony.factory.ImageManager;
    import com.evony.Lang;
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

    public class AutoHealReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _204232454goldNum:int;
        public var _AutoHealReportDetail_Image1:Image;
        public var _AutoHealReportDetail_Label1:Label;
        public var _AutoHealReportDetail_Label2:Label;
        public var _AutoHealReportDetail_Text1:Text;
        private var _877510616goldInclude:Boolean;
        public var _AutoHealReportDetail_HBox1:HBox;
        private var _1562008629troopTypeContainer:VBox;
        private var _99346des:String;
        public var _AutoHealReportDetail_VBox1:VBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Text,
                        "id":"_AutoHealReportDetail_Text1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":10
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "id":"_AutoHealReportDetail_VBox1",
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 2;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":15,
                                "y":38,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_AutoHealReportDetail_HBox1",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 5;
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_AutoHealReportDetail_Image1",
                                                "events":{"complete":"___AutoHealReportDetail_Image1_complete"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":25,
                                                        "height":25
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_AutoHealReportDetail_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":130});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_AutoHealReportDetail_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":90});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"troopTypeContainer"
                                })]
                            });
                        }
                    })]});
            }
        });
        private var ac:ArrayCollection = new ArrayCollection();
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AutoHealReportDetail()
        {
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AutoHealReportDetail_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AutoHealReportDetail._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get goldNum():int
        {
            return (this._204232454goldNum);
        }

        private function getTroopTypeUI(_arg_1:int, _arg_2:int):TroopTypeUI
        {
            var _local_3:TroopTypeUI = (uiCache.getUI(TroopTypeUI) as TroopTypeUI);
            _local_3.imgSrc = _arg_1;
            _local_3.amount = _arg_2;
            return (_local_3);
        }

        private function set goldNum(_arg_1:int):void
        {
            var _local_2:Object = this._204232454goldNum;
            if (_local_2 !== _arg_1)
            {
                this._204232454goldNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldNum", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AutoHealReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AutoHealReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_AutoHealReportDetailWatcherSetupUtil");
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
        private function get des():String
        {
            return (this._99346des);
        }

        private function set des(_arg_1:String):void
        {
            var _local_2:Object = this._99346des;
            if (_local_2 !== _arg_1)
            {
                this._99346des = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "des", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        private function get goldInclude():Boolean
        {
            return (this._877510616goldInclude);
        }

        [Bindable(event="propertyChange")]
        public function get troopTypeContainer():VBox
        {
            return (this._1562008629troopTypeContainer);
        }

        public function ___AutoHealReportDetail_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set xmlObj(_arg_1:ObjectProxy):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            this.ac.removeAll();
            this.uiCache.reset();
            if (_arg_1.hasOwnProperty("gold"))
            {
                goldInclude = true;
                goldNum = -(_arg_1.gold);
            }
            else
            {
                goldInclude = false;
            };
            des = _arg_1.des;
            if ((_arg_1.troopUnit is ArrayCollection))
            {
                _local_2 = (_arg_1.troopUnit as ArrayCollection);
                _local_3 = 0;
                while (_local_3 < _local_2.length)
                {
                    this.ac.addItem(this.getTroopTypeUI(_local_2[_local_3].typeId, _local_2[_local_3].count));
                    _local_3++;
                };
            }
            else
            {
                this.ac.addItem(this.getTroopTypeUI(_arg_1.troopUnit.typeId, _arg_1.troopUnit.count));
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function set goldInclude(_arg_1:Boolean):void
        {
            var _local_2:Object = this._877510616goldInclude;
            if (_local_2 !== _arg_1)
            {
                this._877510616goldInclude = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldInclude", _local_2, _arg_1));
            };
        }

        private function _AutoHealReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = des;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AutoHealReportDetail_Text1.text = _arg_1;
            }, "_AutoHealReportDetail_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (goldInclude);
            }, function (_arg_1:Boolean):void
            {
                _AutoHealReportDetail_VBox1.visible = _arg_1;
            }, "_AutoHealReportDetail_VBox1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (goldInclude);
            }, function (_arg_1:Boolean):void
            {
                _AutoHealReportDetail_HBox1.includeInLayout = _arg_1;
            }, "_AutoHealReportDetail_HBox1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (goldInclude);
            }, function (_arg_1:Boolean):void
            {
                _AutoHealReportDetail_HBox1.visible = _arg_1;
            }, "_AutoHealReportDetail_HBox1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getResourceLogo("gold"));
            }, function (_arg_1:Object):void
            {
                _AutoHealReportDetail_Image1.source = _arg_1;
            }, "_AutoHealReportDetail_Image1.source");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("黄金");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AutoHealReportDetail_Label1.text = _arg_1;
            }, "_AutoHealReportDetail_Label1.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.goldNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AutoHealReportDetail_Label2.text = _arg_1;
            }, "_AutoHealReportDetail_Label2.text");
            result[6] = binding;
            return (result);
        }

        private function refresh():void
        {
            var _local_1:TroopTypeUI;
            this.troopTypeContainer.removeAllChildren();
            for each (_local_1 in this.ac)
            {
                this.troopTypeContainer.addChild(_local_1);
            };
        }

        private function _AutoHealReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = des;
            _local_1 = goldInclude;
            _local_1 = goldInclude;
            _local_1 = goldInclude;
            _local_1 = ImageManager.getResourceLogo("gold");
            _local_1 = Lang.msg("黄金");
            _local_1 = this.goldNum;
        }

        public function ___AutoHealReportDetail_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set troopTypeContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1562008629troopTypeContainer;
            if (_local_2 !== _arg_1)
            {
                this._1562008629troopTypeContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopTypeContainer", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

