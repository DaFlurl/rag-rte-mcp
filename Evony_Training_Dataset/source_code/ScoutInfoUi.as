// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.ScoutInfoUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.FormHeading;
    import view.ui.MyHRule;
    import mx.containers.HBox;
    import mx.utils.ObjectProxy;
    import mx.containers.VBox;
    import mx.controls.Label;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.Lang;
    import mx.binding.Binding;
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

    public class ScoutInfoUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ScoutInfoUi_FormHeading11:FormHeading;
        public var _ScoutInfoUi_FormHeading12:FormHeading;
        public var _ScoutInfoUi_MyHRule8:MyHRule;
        public var _ScoutInfoUi_MyHRule3:MyHRule;
        public var _ScoutInfoUi_ScColonialTroopUi1:ScColonialTroopUi;
        public var _ScoutInfoUi_HBox3:HBox;
        public var _ScoutInfoUi_HBox4:HBox;
        private var _1584232309scoutInfoObj:ObjectProxy;
        public var _ScoutInfoUi_ScFortificationUi1:ScFortificationUi;
        public var _ScoutInfoUi_MyHRule10:MyHRule;
        public var _ScoutInfoUi_MyHRule12:MyHRule;
        public var _ScoutInfoUi_MyHRule14:MyHRule;
        public var _ScoutInfoUi_VBox1:VBox;
        public var _ScoutInfoUi_VBox2:VBox;
        public var _ScoutInfoUi_VBox3:VBox;
        public var _ScoutInfoUi_VBox4:VBox;
        public var _ScoutInfoUi_VBox5:VBox;
        public var _ScoutInfoUi_VBox6:VBox;
        public var _ScoutInfoUi_VBox7:VBox;
        private var _1039609319scBuildObj:ObjectProxy;
        public var _ScoutInfoUi_Label1:Label;
        public var _ScoutInfoUi_Label2:Label;
        public var _ScoutInfoUi_ScBuildingUi1:ScBuildingUi;
        public var _ScoutInfoUi_Label4:Label;
        public var _ScoutInfoUi_Label5:Label;
        public var _ScoutInfoUi_Label6:Label;
        public var _ScoutInfoUi_Label3:Label;
        public var _ScoutInfoUi_FormHeading1:FormHeading;
        public var _ScoutInfoUi_FormHeading2:FormHeading;
        public var _ScoutInfoUi_FormHeading3:FormHeading;
        public var _ScoutInfoUi_FormHeading4:FormHeading;
        public var _ScoutInfoUi_FormHeading5:FormHeading;
        public var _ScoutInfoUi_FormHeading6:FormHeading;
        public var _ScoutInfoUi_FormHeading7:FormHeading;
        public var _ScoutInfoUi_FormHeading8:FormHeading;
        public var _ScoutInfoUi_FormHeading9:FormHeading;
        public var _ScoutInfoUi_ScTeachUi1:ScTeachUi;
        public var _ScoutInfoUi_ScTroopUi1:ScTroopUi;
        private var _28098492scFortObj:ObjectProxy;
        private var _1345611010resoureObj:ObjectProxy;
        private var _400743530scColonialTroopObj:ObjectProxy;
        private var _1286177102scTeachObj:ObjectProxy;
        private var _2073564853scTroopObj:ObjectProxy;
        public var _ScoutInfoUi_Image1:Image;
        public var _ScoutInfoUi_ScResource1:ScResource;
        public var _ScoutInfoUi_MyHRule1:MyHRule;
        public var _ScoutInfoUi_MyHRule4:MyHRule;
        public var _ScoutInfoUi_MyHRule5:MyHRule;
        public var _ScoutInfoUi_MyHRule6:MyHRule;
        public var _ScoutInfoUi_FormHeading10:FormHeading;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_ScoutInfoUi_Image1",
                                                "events":{"complete":"___ScoutInfoUi_Image1_complete"}
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScoutInfoUi_Label1"
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScoutInfoUi_Label2"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutInfoUi_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_ScoutInfoUi_VBox1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 3;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":150});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            }
                                                        })]
                                                    });
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
                                                "type":ScResource,
                                                "id":"_ScoutInfoUi_ScResource1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutInfoUi_MyHRule3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_ScoutInfoUi_VBox2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_ScoutInfoUi_FormHeading3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":150});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_ScoutInfoUi_MyHRule4",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ScoutInfoUi_HBox3",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ScoutInfoUi_Label3",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":145});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ScoutInfoUi_Label4"
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_ScoutInfoUi_MyHRule5",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ScoutInfoUi_HBox4",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ScoutInfoUi_Label5",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":145});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ScoutInfoUi_Label6"
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutInfoUi_MyHRule6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_ScoutInfoUi_VBox3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 3;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading4",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":150});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading5"
                                                        })]
                                                    });
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
                                                "type":ScBuildingUi,
                                                "id":"_ScoutInfoUi_ScBuildingUi1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutInfoUi_MyHRule8",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_ScoutInfoUi_VBox4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 3;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading6",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":150});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading7"
                                                        })]
                                                    });
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
                                                "type":ScFortificationUi,
                                                "id":"_ScoutInfoUi_ScFortificationUi1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutInfoUi_MyHRule10",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_ScoutInfoUi_VBox5",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 3;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading8",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":150});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading9"
                                                        })]
                                                    });
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
                                                "type":ScTroopUi,
                                                "id":"_ScoutInfoUi_ScTroopUi1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutInfoUi_MyHRule12",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_ScoutInfoUi_VBox6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_ScoutInfoUi_FormHeading10",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":150});
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
                                                "type":ScColonialTroopUi,
                                                "id":"_ScoutInfoUi_ScColonialTroopUi1"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutInfoUi_MyHRule14",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"_ScoutInfoUi_VBox7",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 3;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading11",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":150});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":FormHeading,
                                                            "id":"_ScoutInfoUi_FormHeading12"
                                                        })]
                                                    });
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
                                                "type":ScTeachUi,
                                                "id":"_ScoutInfoUi_ScTeachUi1"
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

        public function ScoutInfoUi()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ScoutInfoUi._watcherSetupUtil = _arg_1;
        }


        private function set resoureObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1345611010resoureObj;
            if (_local_2 !== _arg_1)
            {
                this._1345611010resoureObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resoureObj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get resoureObj():ObjectProxy
        {
            return (this._1345611010resoureObj);
        }

        private function set scoutInfoObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1584232309scoutInfoObj;
            if (_local_2 !== _arg_1)
            {
                this._1584232309scoutInfoObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scoutInfoObj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get scBuildObj():ObjectProxy
        {
            return (this._1039609319scBuildObj);
        }

        private function set scBuildObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1039609319scBuildObj;
            if (_local_2 !== _arg_1)
            {
                this._1039609319scBuildObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scBuildObj", _local_2, _arg_1));
            };
        }

        public function ___ScoutInfoUi_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function set scTeachObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1286177102scTeachObj;
            if (_local_2 !== _arg_1)
            {
                this._1286177102scTeachObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scTeachObj", _local_2, _arg_1));
            };
        }

        private function _ScoutInfoUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.scoutInfoObj.heroUrl;
            _local_1 = ((this.scoutInfoObj.heroUrl == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.heroUrl == null) ? false : true);
            _local_1 = this.scoutInfoObj.heroName;
            _local_1 = ((this.scoutInfoObj.heroName == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.heroName == null) ? false : true);
            _local_1 = (((("(" + Lang.msg("级别")) + " ") + this.scoutInfoObj.heroLevel) + ")");
            _local_1 = ((this.scoutInfoObj.heroLevel == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.heroLevel == null) ? false : true);
            _local_1 = ((this.resoureObj == null) ? false : true);
            _local_1 = ((this.resoureObj == null) ? false : true);
            _local_1 = ((this.resoureObj == null) ? false : true);
            _local_1 = ((this.resoureObj == null) ? false : true);
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("数量");
            _local_1 = this.resoureObj;
            _local_1 = this.scoutInfoObj;
            _local_1 = (((!(this.scoutInfoObj.gold == null)) || (!(this.scoutInfoObj.population == null))) || (!(this.scoutInfoObj.support == null)));
            _local_1 = (((!(this.scoutInfoObj.gold == null)) || (!(this.scoutInfoObj.population == null))) || (!(this.scoutInfoObj.support == null)));
            _local_1 = ((!(this.scoutInfoObj.population == null)) || (!(this.scoutInfoObj.support == null)));
            _local_1 = ((!(this.scoutInfoObj.population == null)) || (!(this.scoutInfoObj.support == null)));
            _local_1 = Lang.msg("城市调查");
            _local_1 = ((this.scoutInfoObj.population == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.population == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.population == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.population == null) ? false : true);
            _local_1 = Lang.msg("人口");
            _local_1 = this.scoutInfoObj.population;
            _local_1 = ((this.scoutInfoObj.support == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.support == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.support == null) ? false : true);
            _local_1 = ((this.scoutInfoObj.support == null) ? false : true);
            _local_1 = Lang.msg("民心");
            _local_1 = this.scoutInfoObj.support;
            _local_1 = ((this.scBuildObj == null) ? false : true);
            _local_1 = ((this.scBuildObj == null) ? false : true);
            _local_1 = ((this.scBuildObj == null) ? false : true);
            _local_1 = ((this.scBuildObj == null) ? false : true);
            _local_1 = Lang.msg("建筑");
            _local_1 = Lang.msg("等级");
            _local_1 = this.scBuildObj;
            _local_1 = ((this.scFortObj == null) ? false : true);
            _local_1 = ((this.scFortObj == null) ? false : true);
            _local_1 = ((this.scFortObj == null) ? false : true);
            _local_1 = ((this.scFortObj == null) ? false : true);
            _local_1 = Lang.msg("城防");
            _local_1 = Lang.msg("数量");
            _local_1 = this.scFortObj;
            _local_1 = ((this.scTroopObj == null) ? false : true);
            _local_1 = ((this.scTroopObj == null) ? false : true);
            _local_1 = ((this.scTroopObj == null) ? false : true);
            _local_1 = ((this.scTroopObj == null) ? false : true);
            _local_1 = Lang.msg("军队");
            _local_1 = Lang.msg("数量");
            _local_1 = this.scTroopObj;
            _local_1 = ((this.scColonialTroopObj == null) ? false : true);
            _local_1 = ((this.scColonialTroopObj == null) ? false : true);
            _local_1 = ((this.scColonialTroopObj == null) ? false : true);
            _local_1 = ((this.scColonialTroopObj == null) ? false : true);
            _local_1 = Lang.msg("殖民地信息");
            _local_1 = this.scColonialTroopObj;
            _local_1 = ((this.scTeachObj == null) ? false : true);
            _local_1 = ((this.scTeachObj == null) ? false : true);
            _local_1 = ((this.scTeachObj == null) ? false : true);
            _local_1 = ((this.scTeachObj == null) ? false : true);
            _local_1 = Lang.msg("科技");
            _local_1 = Lang.msg("等级");
            _local_1 = this.scTeachObj;
        }

        private function set scFortObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._28098492scFortObj;
            if (_local_2 !== _arg_1)
            {
                this._28098492scFortObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scFortObj", _local_2, _arg_1));
            };
        }

        private function set scTroopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._2073564853scTroopObj;
            if (_local_2 !== _arg_1)
            {
                this._2073564853scTroopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scTroopObj", _local_2, _arg_1));
            };
        }

        private function _ScoutInfoUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.scoutInfoObj.heroUrl);
            }, function (_arg_1:Object):void
            {
                _ScoutInfoUi_Image1.source = _arg_1;
            }, "_ScoutInfoUi_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.heroUrl == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_Image1.visible = _arg_1;
            }, "_ScoutInfoUi_Image1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.heroUrl == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_Image1.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_Image1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.scoutInfoObj.heroName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_Label1.text = _arg_1;
            }, "_ScoutInfoUi_Label1.text");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.heroName == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_Label1.visible = _arg_1;
            }, "_ScoutInfoUi_Label1.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.heroName == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_Label1.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_Label1.includeInLayout");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((("(" + Lang.msg("级别")) + " ") + this.scoutInfoObj.heroLevel) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_Label2.text = _arg_1;
            }, "_ScoutInfoUi_Label2.text");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.heroLevel == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_Label2.visible = _arg_1;
            }, "_ScoutInfoUi_Label2.visible");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.heroLevel == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_Label2.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_Label2.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resoureObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule1.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule1.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resoureObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule1.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule1.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resoureObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox1.visible = _arg_1;
            }, "_ScoutInfoUi_VBox1.visible");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.resoureObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox1.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_VBox1.includeInLayout");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading1.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading1.label");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading2.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading2.label");
            result[14] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.resoureObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutInfoUi_ScResource1.resourceObj = _arg_1;
            }, "_ScoutInfoUi_ScResource1.resourceObj");
            result[15] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.scoutInfoObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutInfoUi_ScResource1.scoutInfoObj = _arg_1;
            }, "_ScoutInfoUi_ScResource1.scoutInfoObj");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((!(this.scoutInfoObj.gold == null)) || (!(this.scoutInfoObj.population == null))) || (!(this.scoutInfoObj.support == null)));
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule3.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule3.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((!(this.scoutInfoObj.gold == null)) || (!(this.scoutInfoObj.population == null))) || (!(this.scoutInfoObj.support == null)));
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule3.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule3.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(this.scoutInfoObj.population == null)) || (!(this.scoutInfoObj.support == null)));
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox2.visible = _arg_1;
            }, "_ScoutInfoUi_VBox2.visible");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(this.scoutInfoObj.population == null)) || (!(this.scoutInfoObj.support == null)));
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox2.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_VBox2.includeInLayout");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城市调查");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading3.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading3.label");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.population == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule4.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule4.visible");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.population == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule4.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule4.includeInLayout");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.population == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_HBox3.visible = _arg_1;
            }, "_ScoutInfoUi_HBox3.visible");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.population == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_HBox3.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_HBox3.includeInLayout");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_Label3.text = _arg_1;
            }, "_ScoutInfoUi_Label3.text");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.scoutInfoObj.population;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_Label4.text = _arg_1;
            }, "_ScoutInfoUi_Label4.text");
            result[27] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule5.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule5.visible");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule5.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule5.includeInLayout");
            result[29] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_HBox4.visible = _arg_1;
            }, "_ScoutInfoUi_HBox4.visible");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scoutInfoObj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_HBox4.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_HBox4.includeInLayout");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民心");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_Label5.text = _arg_1;
            }, "_ScoutInfoUi_Label5.text");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.scoutInfoObj.support;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_Label6.text = _arg_1;
            }, "_ScoutInfoUi_Label6.text");
            result[33] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scBuildObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule6.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule6.visible");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scBuildObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule6.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule6.includeInLayout");
            result[35] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scBuildObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox3.visible = _arg_1;
            }, "_ScoutInfoUi_VBox3.visible");
            result[36] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scBuildObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox3.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_VBox3.includeInLayout");
            result[37] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建筑");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading4.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading4.label");
            result[38] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading5.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading5.label");
            result[39] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.scBuildObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutInfoUi_ScBuildingUi1.building = _arg_1;
            }, "_ScoutInfoUi_ScBuildingUi1.building");
            result[40] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scFortObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule8.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule8.visible");
            result[41] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scFortObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule8.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule8.includeInLayout");
            result[42] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scFortObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox4.visible = _arg_1;
            }, "_ScoutInfoUi_VBox4.visible");
            result[43] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scFortObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox4.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_VBox4.includeInLayout");
            result[44] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城防");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading6.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading6.label");
            result[45] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading7.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading7.label");
            result[46] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.scFortObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutInfoUi_ScFortificationUi1.fortification = _arg_1;
            }, "_ScoutInfoUi_ScFortificationUi1.fortification");
            result[47] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule10.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule10.visible");
            result[48] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule10.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule10.includeInLayout");
            result[49] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox5.visible = _arg_1;
            }, "_ScoutInfoUi_VBox5.visible");
            result[50] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox5.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_VBox5.includeInLayout");
            result[51] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading8.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading8.label");
            result[52] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading9.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading9.label");
            result[53] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.scTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutInfoUi_ScTroopUi1.troop = _arg_1;
            }, "_ScoutInfoUi_ScTroopUi1.troop");
            result[54] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scColonialTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule12.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule12.visible");
            result[55] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scColonialTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule12.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule12.includeInLayout");
            result[56] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scColonialTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox6.visible = _arg_1;
            }, "_ScoutInfoUi_VBox6.visible");
            result[57] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scColonialTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox6.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_VBox6.includeInLayout");
            result[58] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("殖民地信息");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading10.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading10.label");
            result[59] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.scColonialTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutInfoUi_ScColonialTroopUi1.troop = _arg_1;
            }, "_ScoutInfoUi_ScColonialTroopUi1.troop");
            result[60] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTeachObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule14.visible = _arg_1;
            }, "_ScoutInfoUi_MyHRule14.visible");
            result[61] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTeachObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_MyHRule14.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_MyHRule14.includeInLayout");
            result[62] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTeachObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox7.visible = _arg_1;
            }, "_ScoutInfoUi_VBox7.visible");
            result[63] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.scTeachObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutInfoUi_VBox7.includeInLayout = _arg_1;
            }, "_ScoutInfoUi_VBox7.includeInLayout");
            result[64] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("科技");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading11.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading11.label");
            result[65] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutInfoUi_FormHeading12.label = _arg_1;
            }, "_ScoutInfoUi_FormHeading12.label");
            result[66] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.scTeachObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutInfoUi_ScTeachUi1.teach = _arg_1;
            }, "_ScoutInfoUi_ScTeachUi1.teach");
            result[67] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get scoutInfoObj():ObjectProxy
        {
            return (this._1584232309scoutInfoObj);
        }

        [Bindable(event="propertyChange")]
        private function get scColonialTroopObj():ObjectProxy
        {
            return (this._400743530scColonialTroopObj);
        }

        override public function initialize():void
        {
            var target:ScoutInfoUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ScoutInfoUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_ScoutInfoUiWatcherSetupUtil");
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

        public function set scoutInfo(_arg_1:ObjectProxy):void
        {
            this.scoutInfoObj = _arg_1;
            this.resoureObj = _arg_1.resource;
            this.scFortObj = _arg_1.fortifications;
            this.scTroopObj = _arg_1.troops;
            this.scColonialTroopObj = _arg_1.colonies;
            this.scBuildObj = _arg_1.buildings;
            this.scTeachObj = _arg_1.techs;
            if (((!(_arg_1.resource == null)) && (_arg_1.resource is Object)))
            {
                this.resoureObj = (_arg_1.resource as ObjectProxy);
            };
            if (((!(_arg_1.fortifications == null)) && (_arg_1.fortifications is Object)))
            {
                this.scFortObj = (_arg_1.fortifications as ObjectProxy);
            };
            if (((!(_arg_1.troops == null)) && (_arg_1.troops is Object)))
            {
                this.scTroopObj = (_arg_1.troops as ObjectProxy);
            };
            if (((!(_arg_1.colonies == null)) && (_arg_1.colonies is Object)))
            {
                this.scColonialTroopObj = (_arg_1.colonies as ObjectProxy);
            };
            if (((!(_arg_1.buildings == null)) && (_arg_1.buildings is Object)))
            {
                this.scBuildObj = (_arg_1.buildings as ObjectProxy);
            };
            if (((!(_arg_1.techs == null)) && (_arg_1.techs is Object)))
            {
                this.scTeachObj = (_arg_1.techs as ObjectProxy);
            };
        }

        [Bindable(event="propertyChange")]
        private function get scFortObj():ObjectProxy
        {
            return (this._28098492scFortObj);
        }

        [Bindable(event="propertyChange")]
        private function get scTroopObj():ObjectProxy
        {
            return (this._2073564853scTroopObj);
        }

        [Bindable(event="propertyChange")]
        private function get scTeachObj():ObjectProxy
        {
            return (this._1286177102scTeachObj);
        }

        private function set scColonialTroopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._400743530scColonialTroopObj;
            if (_local_2 !== _arg_1)
            {
                this._400743530scColonialTroopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scColonialTroopObj", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

