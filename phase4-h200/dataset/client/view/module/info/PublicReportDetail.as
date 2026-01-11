// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.PublicReportDetail

package view.module.info
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.reports.DeclareWarReportDetail;
    import mx.controls.Label;
    import view.module.info.reports.TradeReportDetail;
    import view.module.info.reports.RobReportDetail;
    import view.module.info.reports.AbandonmentReport;
    import view.module.info.reports.ScoutReportDetail;
    import mx.controls.Text;
    import view.module.info.reports.PolicyReportDetail;
    import com.evony.common.beans.ReportBean;
    import mx.containers.ViewStack;
    import view.module.info.reports.TroopMovementDetail;
    import view.module.info.reports.SowDiscordReportDetail;
    import view.module.info.reports.HeroEscapeReportDetail;
    import view.module.info.reports.TroopMoveList;
    import view.module.info.reports.TroopDieReportDetail;
    import view.module.info.reports.BattleReportDetail;
    import view.module.info.reports.UprisingWarReport;
    import com.evony.common.beans.MilitarySituation;
    import view.module.info.reports.ImpositionReport;
    import view.module.info.reports.UprisingReportDetail;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.VRule;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    import mx.utils.XMLUtil;
    import flash.xml.XMLDocument;
    import mx.rpc.xml.SimpleXMLDecoder;
    import mx.core.Container;
    import mx.utils.ObjectProxy;
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
    import view.module.info.reports.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class PublicReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1361090993declareWarReportVs:DeclareWarReportDetail;
        public var _PublicReportDetail_Label2:Label;
        private var _1053256555tradeReportVs:TradeReportDetail;
        private var _431461386robReportVs:RobReportDetail;
        private var _1165223268abandonmentReportVS:AbandonmentReport;
        private var _1823582255scoutReportVs:ScoutReportDetail;
        private var _877169937testVs:Canvas;
        public var _PublicReportDetail_Text1:Text;
        private var _62691939policyReportVs:PolicyReportDetail;
        private var _3019696bean:ReportBean;
        private var _946505330viewstack1:ViewStack;
        private var _1966809278troopMovementVs:TroopMovementDetail;
        private var _892004994strUrl:String = "";
        private var _271824606sowDiscordReportVS:SowDiscordReportDetail;
        private var _890907316heroEscapeReportVs:HeroEscapeReportDetail;
        private var _1025890334troopMoveListVs:TroopMoveList;
        private var _432366847troopDieReportVs:TroopDieReportDetail;
        private var _1125015529battleReportVs:BattleReportDetail;
        private var _535137176uprisingWarReportVS:UprisingWarReport;
        private var _103898970miliS:MilitarySituation;
        private var _40823902impositionReportVS:ImpositionReport;
        private var _532513326uprisingReportVs:UprisingReportDetail;
        public var _PublicReportDetail_Label4:Label;
        private var _1650629499ReportUrl:Label;
        public var _PublicReportDetail_Label3:Label;
        public var _PublicReportDetail_Label5:Label;
        public var _PublicReportDetail_Label6:Label;
        public var _PublicReportDetail_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":755,
                    "height":376,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.right = "0";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"newBackGroundWithBode",
                                "height":56,
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 3;
                                        this.left = "0";
                                        this.right = "0";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                    this.horizontalAlign = "center";
                                                    this.verticalAlign = "top";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":23,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":33.33,
                                                                    "height":23,
                                                                    "styleName":"textBackGroundFillColor",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PublicReportDetail_Label1",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                            this.horizontalCenter = "0";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":33.33,
                                                                    "height":23,
                                                                    "styleName":"textBackGroundFillColor",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PublicReportDetail_Label2",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                            this.horizontalCenter = "0";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":33.33,
                                                                    "height":23,
                                                                    "styleName":"textBackGroundFillColor",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_PublicReportDetail_Label3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                            this.horizontalCenter = "0";
                                                                            this.verticalCenter = "0";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PublicReportDetail_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":33.3,
                                                                    "height":23,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PublicReportDetail_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":33.3,
                                                                    "height":23,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PublicReportDetail_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":33.3,
                                                                    "height":23,
                                                                    "selectable":false
                                                                });
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
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.top = "61";
                            this.bottom = "20";
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":225,
                                "styleName":"newBackGroundWithBode",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"testVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_PublicReportDetail_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "0";
                                                    this.bottom = "0";
                                                    this.paddingLeft = 10;
                                                    this.paddingRight = 10;
                                                    this.paddingTop = 10;
                                                    this.paddingBottom = 10;
                                                    this.textAlign = "left";
                                                    this.right = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TradeReportDetail,
                                    "id":"tradeReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":UprisingReportDetail,
                                    "id":"uprisingReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HeroEscapeReportDetail,
                                    "id":"heroEscapeReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TroopDieReportDetail,
                                    "id":"troopDieReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":BattleReportDetail,
                                    "id":"battleReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ScoutReportDetail,
                                    "id":"scoutReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TroopMovementDetail,
                                    "id":"troopMovementVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RobReportDetail,
                                    "id":"robReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DeclareWarReportDetail,
                                    "id":"declareWarReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":PolicyReportDetail,
                                    "id":"policyReportVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TroopMoveList,
                                    "id":"troopMoveListVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":UprisingWarReport,
                                    "id":"uprisingWarReportVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ImpositionReport,
                                    "id":"impositionReportVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AbandonmentReport,
                                    "id":"abandonmentReportVS",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":SowDiscordReportDetail,
                                    "id":"sowDiscordReportVS",
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
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.left = "0";
                            this.top = "346";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"newBackGroundWithBode",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 1;
                                        this.left = "0";
                                        this.right = "0";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"ReportUrl",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":20,
                                                                    "styleName":"focusColor",
                                                                    "selectable":true
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]});
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

        public function PublicReportDetail()
        {
            mx_internal::_document = this;
            this.x = 0;
            this.y = 35;
            this.width = 755;
            this.height = 376;
            this.addEventListener("creationComplete", ___PublicReportDetail_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PublicReportDetail._watcherSetupUtil = _arg_1;
        }


        public function set reportBean(_arg_1:ReportBean):void
        {
            this.bean = _arg_1;
            if (((this.initialized) && (!(_arg_1.content == ""))))
            {
                this.refresh(_arg_1.content, _arg_1);
            };
        }

        public function set troopDieReportVs(_arg_1:TroopDieReportDetail):void
        {
            var _local_2:Object = this._432366847troopDieReportVs;
            if (_local_2 !== _arg_1)
            {
                this._432366847troopDieReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopDieReportVs", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            if (this.bean)
            {
                this.refresh(this.bean.content, this.bean);
            }
            else
            {
                if (this.miliS)
                {
                    this.refresh(this.miliS.xml_data, this.miliS);
                };
            };
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get troopMoveListVs():TroopMoveList
        {
            return (this._1025890334troopMoveListVs);
        }

        [Bindable(event="propertyChange")]
        public function get sowDiscordReportVS():SowDiscordReportDetail
        {
            return (this._271824606sowDiscordReportVS);
        }

        public function set tradeReportVs(_arg_1:TradeReportDetail):void
        {
            var _local_2:Object = this._1053256555tradeReportVs;
            if (_local_2 !== _arg_1)
            {
                this._1053256555tradeReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradeReportVs", _local_2, _arg_1));
            };
        }

        private function _PublicReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("主题");
            _local_1 = Lang.msg("时间");
            _local_1 = Lang.msg("发生地");
            _local_1 = ((this.bean == null) ? this.miliS.eventName : this.bean.title);
            _local_1 = ((this.bean == null) ? this.miliS.time : this.bean.eventTime);
            _local_1 = ((this.bean == null) ? this.miliS.targetPos : this.bean.targetPos);
            _local_1 = bean.content;
            _local_1 = this.strUrl;
        }

        [Bindable(event="propertyChange")]
        public function get scoutReportVs():ScoutReportDetail
        {
            return (this._1823582255scoutReportVs);
        }

        public function set uprisingWarReportVS(_arg_1:UprisingWarReport):void
        {
            var _local_2:Object = this._535137176uprisingWarReportVS;
            if (_local_2 !== _arg_1)
            {
                this._535137176uprisingWarReportVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "uprisingWarReportVS", _local_2, _arg_1));
            };
        }

        public function set troopMoveListVs(_arg_1:TroopMoveList):void
        {
            var _local_2:Object = this._1025890334troopMoveListVs;
            if (_local_2 !== _arg_1)
            {
                this._1025890334troopMoveListVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopMoveListVs", _local_2, _arg_1));
            };
        }

        private function _PublicReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("主题");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportDetail_Label1.text = _arg_1;
            }, "_PublicReportDetail_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportDetail_Label2.text = _arg_1;
            }, "_PublicReportDetail_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发生地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportDetail_Label3.text = _arg_1;
            }, "_PublicReportDetail_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.bean == null) ? this.miliS.eventName : this.bean.title);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportDetail_Label4.text = _arg_1;
            }, "_PublicReportDetail_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.bean == null) ? this.miliS.time : this.bean.eventTime);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportDetail_Label5.text = _arg_1;
            }, "_PublicReportDetail_Label5.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.bean == null) ? this.miliS.targetPos : this.bean.targetPos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportDetail_Label6.text = _arg_1;
            }, "_PublicReportDetail_Label6.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = bean.content;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportDetail_Text1.text = _arg_1;
            }, "_PublicReportDetail_Text1.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.strUrl;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                ReportUrl.text = _arg_1;
            }, "ReportUrl.text");
            result[7] = binding;
            return (result);
        }

        public function set sowDiscordReportVS(_arg_1:SowDiscordReportDetail):void
        {
            var _local_2:Object = this._271824606sowDiscordReportVS;
            if (_local_2 !== _arg_1)
            {
                this._271824606sowDiscordReportVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sowDiscordReportVS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroEscapeReportVs():HeroEscapeReportDetail
        {
            return (this._890907316heroEscapeReportVs);
        }

        [Bindable(event="propertyChange")]
        public function get declareWarReportVs():DeclareWarReportDetail
        {
            return (this._1361090993declareWarReportVs);
        }

        [Bindable(event="propertyChange")]
        private function get miliS():MilitarySituation
        {
            return (this._103898970miliS);
        }

        [Bindable(event="propertyChange")]
        public function get impositionReportVS():ImpositionReport
        {
            return (this._40823902impositionReportVS);
        }

        [Bindable(event="propertyChange")]
        public function get policyReportVs():PolicyReportDetail
        {
            return (this._62691939policyReportVs);
        }

        [Bindable(event="propertyChange")]
        public function get abandonmentReportVS():AbandonmentReport
        {
            return (this._1165223268abandonmentReportVS);
        }

        public function set scoutReportVs(_arg_1:ScoutReportDetail):void
        {
            var _local_2:Object = this._1823582255scoutReportVs;
            if (_local_2 !== _arg_1)
            {
                this._1823582255scoutReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scoutReportVs", _local_2, _arg_1));
            };
        }

        private function set bean(_arg_1:ReportBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        public function ___PublicReportDetail_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get ReportUrl():Label
        {
            return (this._1650629499ReportUrl);
        }

        private function onReportUrl(_arg_1:String):void
        {
            _arg_1 = ("http://" + _arg_1);
            navigateToURL(new URLRequest(_arg_1), "_blank");
        }

        [Bindable(event="propertyChange")]
        private function get strUrl():String
        {
            return (this._892004994strUrl);
        }

        public function set troopMovementVs(_arg_1:TroopMovementDetail):void
        {
            var _local_2:Object = this._1966809278troopMovementVs;
            if (_local_2 !== _arg_1)
            {
                this._1966809278troopMovementVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopMovementVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        override public function initialize():void
        {
            var target:PublicReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PublicReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_PublicReportDetailWatcherSetupUtil");
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
        public function get tradeReportVs():TradeReportDetail
        {
            return (this._1053256555tradeReportVs);
        }

        public function set heroEscapeReportVs(_arg_1:HeroEscapeReportDetail):void
        {
            var _local_2:Object = this._890907316heroEscapeReportVs;
            if (_local_2 !== _arg_1)
            {
                this._890907316heroEscapeReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroEscapeReportVs", _local_2, _arg_1));
            };
        }

        public function set uprisingReportVs(_arg_1:UprisingReportDetail):void
        {
            var _local_2:Object = this._532513326uprisingReportVs;
            if (_local_2 !== _arg_1)
            {
                this._532513326uprisingReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "uprisingReportVs", _local_2, _arg_1));
            };
        }

        public function set declareWarReportVs(_arg_1:DeclareWarReportDetail):void
        {
            var _local_2:Object = this._1361090993declareWarReportVs;
            if (_local_2 !== _arg_1)
            {
                this._1361090993declareWarReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declareWarReportVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get uprisingWarReportVS():UprisingWarReport
        {
            return (this._535137176uprisingWarReportVS);
        }

        [Bindable(event="propertyChange")]
        private function get bean():ReportBean
        {
            return (this._3019696bean);
        }

        private function set miliS(_arg_1:MilitarySituation):void
        {
            var _local_2:Object = this._103898970miliS;
            if (_local_2 !== _arg_1)
            {
                this._103898970miliS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "miliS", _local_2, _arg_1));
            };
        }

        public function set impositionReportVS(_arg_1:ImpositionReport):void
        {
            var _local_2:Object = this._40823902impositionReportVS;
            if (_local_2 !== _arg_1)
            {
                this._40823902impositionReportVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "impositionReportVS", _local_2, _arg_1));
            };
        }

        public function set policyReportVs(_arg_1:PolicyReportDetail):void
        {
            var _local_2:Object = this._62691939policyReportVs;
            if (_local_2 !== _arg_1)
            {
                this._62691939policyReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "policyReportVs", _local_2, _arg_1));
            };
        }

        public function set abandonmentReportVS(_arg_1:AbandonmentReport):void
        {
            var _local_2:Object = this._1165223268abandonmentReportVS;
            if (_local_2 !== _arg_1)
            {
                this._1165223268abandonmentReportVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "abandonmentReportVS", _local_2, _arg_1));
            };
        }

        public function set militaryS(_arg_1:MilitarySituation):void
        {
            this.miliS = _arg_1;
            if (((this.initialized) && (!(_arg_1.xml_data == ""))))
            {
                this.refresh(_arg_1.xml_data, _arg_1);
            };
        }

        [Bindable(event="propertyChange")]
        public function get troopMovementVs():TroopMovementDetail
        {
            return (this._1966809278troopMovementVs);
        }

        public function set battleReportVs(_arg_1:BattleReportDetail):void
        {
            var _local_2:Object = this._1125015529battleReportVs;
            if (_local_2 !== _arg_1)
            {
                this._1125015529battleReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "battleReportVs", _local_2, _arg_1));
            };
        }

        public function set testVs(_arg_1:Canvas):void
        {
            var _local_2:Object = this._877169937testVs;
            if (_local_2 !== _arg_1)
            {
                this._877169937testVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "testVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get uprisingReportVs():UprisingReportDetail
        {
            return (this._532513326uprisingReportVs);
        }

        [Bindable(event="propertyChange")]
        public function get battleReportVs():BattleReportDetail
        {
            return (this._1125015529battleReportVs);
        }

        private function refresh(_arg_1:String, _arg_2:*):void
        {
            var _local_7:Object;
            var _local_8:int;
            var _local_9:int;
            var _local_3:XMLDocument = XMLUtil.createXMLDocument(_arg_1);
            var _local_4:SimpleXMLDecoder = new SimpleXMLDecoder(true);
            var _local_5:Object = _local_4.decodeXML(_local_3);
            var _local_6:Container = this.testVs;
            if (((_local_5 is ObjectProxy) && (_local_5.reportData)))
            {
                _local_7 = _local_5.reportData;
                _local_8 = _arg_1.indexOf("reportUrl=");
                if (_local_8 > 0)
                {
                    _local_8 = (_local_8 + 11);
                    _local_9 = _arg_1.indexOf('"', (_local_8 + 1));
                    strUrl = _arg_1.substring(_local_8, _local_9);
                    ReportUrl.text = strUrl;
                }
                else
                {
                    ReportUrl.text = "";
                };
                if (_local_7.tradeReport)
                {
                    this.tradeReportVs.xmlObj = _local_7.tradeReport;
                    _local_6 = this.tradeReportVs;
                }
                else
                {
                    if (_local_7.uprisingReport)
                    {
                        this.uprisingReportVs.setXmlObj(_local_7.uprisingReport, _arg_2.targetPos);
                        _local_6 = this.uprisingReportVs;
                    }
                    else
                    {
                        if (_local_7.heroEscapeReport)
                        {
                            this.heroEscapeReportVs.setXmlObj(_local_7.heroEscapeReport, _arg_2.targetPos);
                            _local_6 = this.heroEscapeReportVs;
                        }
                        else
                        {
                            if (_local_7.troopDieReport)
                            {
                                this.troopDieReportVs.setXmlObj(_local_7.troopDieReport, _arg_2.targetPos);
                                _local_6 = this.troopDieReportVs;
                            }
                            else
                            {
                                if (_local_7.battleReport)
                                {
                                    this.battleReportVs.setXmlObj(_local_7.battleReport, _arg_2.startPos, _arg_2.targetPos);
                                    _local_6 = this.battleReportVs;
                                }
                                else
                                {
                                    if (_local_7.troopMovement)
                                    {
                                        this.troopMovementVs.setXmlObj(_local_7.troopMovement, _arg_2.startPos, _arg_2.targetPos);
                                        _local_6 = this.troopMovementVs;
                                    }
                                    else
                                    {
                                        if (_local_7.scoutReport)
                                        {
                                            this.scoutReportVs.setXmlObj(_local_7.scoutReport, _arg_2.startPos, _arg_2.targetPos);
                                            _local_6 = this.scoutReportVs;
                                        }
                                        else
                                        {
                                            if (_local_7.robReport)
                                            {
                                                this.robReportVs.setXmlObj(_local_7.robReport, _arg_2.startPos, _arg_2.targetPos);
                                                _local_6 = this.robReportVs;
                                            }
                                            else
                                            {
                                                if (_local_7.declaredWarReport)
                                                {
                                                    this.declareWarReportVs.target = this.bean.targetPos;
                                                    this.declareWarReportVs.start = this.bean.startPos;
                                                    this.declareWarReportVs.xmlObj = _local_7.declaredWarReport;
                                                    _local_6 = this.declareWarReportVs;
                                                    this.strUrl = "";
                                                }
                                                else
                                                {
                                                    if (((_local_7.policyReport) || (_local_7.heroFleeReport)))
                                                    {
                                                        this.policyReportVs.xmlObj = _local_7.policyReport;
                                                        _local_6 = this.policyReportVs;
                                                        this.strUrl = "";
                                                    }
                                                    else
                                                    {
                                                        if (_local_7.hasOwnProperty("TroopMoveList"))
                                                        {
                                                            this.troopMoveListVs.setXmlObj(_local_7.TroopMoveList, this.bean.targetPos);
                                                            _local_6 = this.troopMoveListVs;
                                                            this.strUrl = "";
                                                        }
                                                        else
                                                        {
                                                            if (_local_7.uprisingWarReport)
                                                            {
                                                                this.uprisingWarReportVS.setXmlObj(_local_7.uprisingWarReport, _arg_2.startPos, _arg_2.targetPos);
                                                                _local_6 = this.uprisingWarReportVS;
                                                                this.strUrl = "";
                                                            }
                                                            else
                                                            {
                                                                if (_local_7.ImpositionReport)
                                                                {
                                                                    this.impositionReportVS.setXmlObj(_local_7.ImpositionReport);
                                                                    _local_6 = this.impositionReportVS;
                                                                    this.strUrl = "";
                                                                }
                                                                else
                                                                {
                                                                    if (_local_7.ColonyAbadonReport)
                                                                    {
                                                                        this.abandonmentReportVS.setXmlObj(_local_7.ColonyAbadonReport);
                                                                        _local_6 = this.abandonmentReportVS;
                                                                        this.strUrl = "";
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_local_7.sowDiscordReport)
                                                                        {
                                                                            this.sowDiscordReportVS.setXmlObj(_local_7.sowDiscordReport);
                                                                            _local_6 = this.sowDiscordReportVS;
                                                                            this.strUrl = "";
                                                                        };
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                this.viewstack1.selectedChild = _local_6;
            }
            else
            {
                this.viewstack1.selectedChild = testVs;
            };
        }

        [Bindable(event="propertyChange")]
        public function get testVs():Canvas
        {
            return (this._877169937testVs);
        }

        public function set robReportVs(_arg_1:RobReportDetail):void
        {
            var _local_2:Object = this._431461386robReportVs;
            if (_local_2 !== _arg_1)
            {
                this._431461386robReportVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "robReportVs", _local_2, _arg_1));
            };
        }

        public function set ReportUrl(_arg_1:Label):void
        {
            var _local_2:Object = this._1650629499ReportUrl;
            if (_local_2 !== _arg_1)
            {
                this._1650629499ReportUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ReportUrl", _local_2, _arg_1));
            };
        }

        private function set strUrl(_arg_1:String):void
        {
            var _local_2:Object = this._892004994strUrl;
            if (_local_2 !== _arg_1)
            {
                this._892004994strUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get robReportVs():RobReportDetail
        {
            return (this._431461386robReportVs);
        }

        [Bindable(event="propertyChange")]
        public function get troopDieReportVs():TroopDieReportDetail
        {
            return (this._432366847troopDieReportVs);
        }


    }
}//package view.module.info

