// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.UprisingReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.utils.ObjectProxy;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
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

    public class UprisingReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _UprisingReportDetail_Label4:Label;
        public var _UprisingReportDetail_Label5:Label;
        public var _UprisingReportDetail_Label6:Label;
        public var _UprisingReportDetail_Label7:Label;
        public var _UprisingReportDetail_Label8:Label;
        public var _UprisingReportDetail_Label1:Label;
        private var _109815obj:ObjectProxy;
        public var _UprisingReportDetail_Label10:Label;
        public var _UprisingReportDetail_Label11:Label;
        public var _UprisingReportDetail_Label12:Label;
        public var _UprisingReportDetail_Label13:Label;
        public var _UprisingReportDetail_Label14:Label;
        public var _UprisingReportDetail_Text1:Text;
        private var _1112064572castlePos:String;
        public var _UprisingReportDetail_Label2:Label;
        public var _UprisingReportDetail_Label3:Label;
        public var _UprisingReportDetail_Label9:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 2;
                            this.top = "10";
                            this.left = "10";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_UprisingReportDetail_Text1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "y":10,
                                            "percentWidth":100
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
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label8"
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label9"
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label10"
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label11"
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label12"
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label13"
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_UprisingReportDetail_Label14"
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function UprisingReportDetail()
        {
            mx_internal::_document = this;
            this.styleName = "whiteBackGroundWithBode";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            UprisingReportDetail._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:UprisingReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _UprisingReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_UprisingReportDetailWatcherSetupUtil");
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

        private function set castlePos(_arg_1:String):void
        {
            var _local_2:Object = this._1112064572castlePos;
            if (_local_2 !== _arg_1)
            {
                this._1112064572castlePos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castlePos", _local_2, _arg_1));
            };
        }

        private function _UprisingReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.castlePos + " ") + Lang.msg("治理不善"));
            _local_1 = (Lang.msg("人口") + ": ");
            _local_1 = (Lang.msg("黄金") + ": ");
            _local_1 = (Lang.msg("粮食") + ": ");
            _local_1 = (Lang.msg("木材") + ": ");
            _local_1 = (Lang.msg("石料") + ": ");
            _local_1 = (Lang.msg("铁矿") + ": ");
            _local_1 = (Lang.msg("当前民怨") + ": ");
            _local_1 = ("-" + obj.population);
            _local_1 = ("-" + obj.gold);
            _local_1 = ("-" + obj.food);
            _local_1 = ("-" + obj.wood);
            _local_1 = ("-" + obj.stone);
            _local_1 = ("-" + obj.iron);
            _local_1 = ("+" + obj.complaint);
        }

        private function _UprisingReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.castlePos + " ") + Lang.msg("治理不善"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Text1.text = _arg_1;
            }, "_UprisingReportDetail_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人口") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label1.text = _arg_1;
            }, "_UprisingReportDetail_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("黄金") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label2.text = _arg_1;
            }, "_UprisingReportDetail_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("粮食") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label3.text = _arg_1;
            }, "_UprisingReportDetail_Label3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("木材") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label4.text = _arg_1;
            }, "_UprisingReportDetail_Label4.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("石料") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label5.text = _arg_1;
            }, "_UprisingReportDetail_Label5.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("铁矿") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label6.text = _arg_1;
            }, "_UprisingReportDetail_Label6.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前民怨") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label7.text = _arg_1;
            }, "_UprisingReportDetail_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("-" + obj.population);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label8.text = _arg_1;
            }, "_UprisingReportDetail_Label8.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("-" + obj.gold);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label9.text = _arg_1;
            }, "_UprisingReportDetail_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("-" + obj.food);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label10.text = _arg_1;
            }, "_UprisingReportDetail_Label10.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("-" + obj.wood);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label11.text = _arg_1;
            }, "_UprisingReportDetail_Label11.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("-" + obj.stone);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label12.text = _arg_1;
            }, "_UprisingReportDetail_Label12.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("-" + obj.iron);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label13.text = _arg_1;
            }, "_UprisingReportDetail_Label13.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("+" + obj.complaint);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingReportDetail_Label14.text = _arg_1;
            }, "_UprisingReportDetail_Label14.text");
            result[14] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get castlePos():String
        {
            return (this._1112064572castlePos);
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String):void
        {
            this.obj = _arg_1;
            this.castlePos = _arg_2;
        }

        private function set obj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._109815obj;
            if (_local_2 !== _arg_1)
            {
                this._109815obj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "obj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get obj():ObjectProxy
        {
            return (this._109815obj);
        }


    }
}//package view.module.info.reports

