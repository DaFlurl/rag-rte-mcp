// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.TopInfo

package autoevony.gui
{
    import mx.containers.VBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayList;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class TopInfo extends VBox implements IBindingClient 
    {

        private static const AllianceLv1:Class = TopInfo_AllianceLv1;
        private static const AllianceLv2:Class = TopInfo_AllianceLv2;
        private static const AllianceLv3:Class = TopInfo_AllianceLv3;
        private static const AllianceLv4:Class = TopInfo_AllianceLv4;
        private static const AllianceLv5:Class = TopInfo_AllianceLv5;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1019789636office:String;
        private var _1806944311alliance:String;
        private var _99462250honor:String;
        private var _3506294role:String;
        public var _TopInfo_Label1:Label;
        public var _TopInfo_Label2:Label;
        public var _TopInfo_Label3:Label;
        public var _TopInfo_Label4:Label;
        public var _TopInfo_Label5:Label;
        public var _TopInfo_Label6:Label;
        public var _TopInfo_Label7:Label;
        public var _TopInfo_Label9:Label;
        public var _TopInfo_Label8:Label;
        private var _3172656gift:String;
        public var _TopInfo_Image7:Image;
        private var _975146800gameCoins:String;
        private var _905826493server:String;
        private var _1276224445prestige:String;
        private var _1376863085roleImg:int;
        public var _TopInfo_Label10:Label;
        private var _978111542ranking:String;
        private var _110371416title:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":600,
                    "height":41,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.paddingLeft = 25;
                            this.paddingRight = 5;
                            this.paddingTop = 1;
                            this.paddingBottom = 2;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":40,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_Age2Quest_png_2079013973});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":105,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Server"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_alliance_png_1159272469});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":90,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Alliance"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_prestige_png_988543979});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":90,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Prestige"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_rank_png_1843179317});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":85,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Office"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_gameCoins_png_216677973});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":80,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Cents / Game coins"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "maxWidth":690,
                                "height":2,
                                "styleName":"horizontalSeparator2pxLine"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.paddingLeft = 25;
                            this.paddingRight = 0;
                            this.paddingTop = 1;
                            this.paddingBottom = 1;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":17});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_ranking_png_445787723});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":105,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label6",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Rank by Prestige"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_TopInfo_Image7"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":90,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Alliance Role"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_honor_png_2025036117});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":90,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label8",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Honor"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_title_png_2018272843});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":85,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Title"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":23,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":_embed_mxml_autoevony_gui_images_gift_png_2082389813});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":80,
                                            "height":17,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_TopInfo_Label10",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontFamily = "DejaVu Sans";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"toolTip":"Available Packages"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        private var _1569142294allianceLvLArr:ArrayList = new ArrayList([AllianceLv5, AllianceLv4, AllianceLv3, AllianceLv2, AllianceLv1]);
        private var _embed_mxml_autoevony_gui_images_Age2Quest_png_2079013973:Class = TopInfo__embed_mxml_autoevony_gui_images_Age2Quest_png_2079013973;
        private var _embed_mxml_autoevony_gui_images_alliance_png_1159272469:Class = TopInfo__embed_mxml_autoevony_gui_images_alliance_png_1159272469;
        private var _embed_mxml_autoevony_gui_images_gameCoins_png_216677973:Class = TopInfo__embed_mxml_autoevony_gui_images_gameCoins_png_216677973;
        private var _embed_mxml_autoevony_gui_images_gift_png_2082389813:Class = TopInfo__embed_mxml_autoevony_gui_images_gift_png_2082389813;
        private var _embed_mxml_autoevony_gui_images_honor_png_2025036117:Class = TopInfo__embed_mxml_autoevony_gui_images_honor_png_2025036117;
        private var _embed_mxml_autoevony_gui_images_prestige_png_988543979:Class = TopInfo__embed_mxml_autoevony_gui_images_prestige_png_988543979;
        private var _embed_mxml_autoevony_gui_images_rank_png_1843179317:Class = TopInfo__embed_mxml_autoevony_gui_images_rank_png_1843179317;
        private var _embed_mxml_autoevony_gui_images_ranking_png_445787723:Class = TopInfo__embed_mxml_autoevony_gui_images_ranking_png_445787723;
        private var _embed_mxml_autoevony_gui_images_title_png_2018272843:Class = TopInfo__embed_mxml_autoevony_gui_images_title_png_2018272843;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TopInfo()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalAlign = "center";
                this.horizontalGap = 0;
                this.verticalGap = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
            };
            this.width = 600;
            this.height = 41;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TopInfo._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get allianceLvLArr():ArrayList
        {
            return (this._1569142294allianceLvLArr);
        }

        [Bindable(event="propertyChange")]
        public function get gameCoins():String
        {
            return (this._975146800gameCoins);
        }

        [Bindable(event="propertyChange")]
        public function get ranking():String
        {
            return (this._978111542ranking);
        }

        [Bindable(event="propertyChange")]
        public function get alliance():String
        {
            return (this._1806944311alliance);
        }

        private function set allianceLvLArr(_arg_1:ArrayList):void
        {
            var _local_2:Object = this._1569142294allianceLvLArr;
            if (_local_2 !== _arg_1)
            {
                this._1569142294allianceLvLArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceLvLArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get gift():String
        {
            return (this._3172656gift);
        }

        [Bindable(event="propertyChange")]
        public function get server():String
        {
            return (this._905826493server);
        }

        [Bindable(event="propertyChange")]
        public function get title():String
        {
            return (this._110371416title);
        }

        [Bindable(event="propertyChange")]
        public function get prestige():String
        {
            return (this._1276224445prestige);
        }

        public function set gameCoins(_arg_1:String):void
        {
            var _local_2:Object = this._975146800gameCoins;
            if (_local_2 !== _arg_1)
            {
                this._975146800gameCoins = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gameCoins", _local_2, _arg_1));
            };
        }

        public function set gift(_arg_1:String):void
        {
            var _local_2:Object = this._3172656gift;
            if (_local_2 !== _arg_1)
            {
                this._3172656gift = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gift", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get honor():String
        {
            return (this._99462250honor);
        }

        public function set ranking(_arg_1:String):void
        {
            var _local_2:Object = this._978111542ranking;
            if (_local_2 !== _arg_1)
            {
                this._978111542ranking = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ranking", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get roleImg():int
        {
            return (this._1376863085roleImg);
        }

        public function set alliance(_arg_1:String):void
        {
            var _local_2:Object = this._1806944311alliance;
            if (_local_2 !== _arg_1)
            {
                this._1806944311alliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alliance", _local_2, _arg_1));
            };
        }

        public function set office(_arg_1:String):void
        {
            var _local_2:Object = this._1019789636office;
            if (_local_2 !== _arg_1)
            {
                this._1019789636office = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "office", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get role():String
        {
            return (this._3506294role);
        }

        public function set prestige(_arg_1:String):void
        {
            var _local_2:Object = this._1276224445prestige;
            if (_local_2 !== _arg_1)
            {
                this._1276224445prestige = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _local_2, _arg_1));
            };
        }

        public function set server(_arg_1:String):void
        {
            var _local_2:Object = this._905826493server;
            if (_local_2 !== _arg_1)
            {
                this._905826493server = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "server", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TopInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._TopInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_TopInfoWatcherSetupUtil");
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

        public function set title(_arg_1:String):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        private function _TopInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.server;
            _local_1 = this.alliance;
            _local_1 = this.prestige;
            _local_1 = this.office;
            _local_1 = this.gameCoins;
            _local_1 = this.ranking;
            _local_1 = this.allianceLvLArr.getItemAt(this.roleImg);
            _local_1 = this.role;
            _local_1 = this.honor;
            _local_1 = this.title;
            _local_1 = this.gift;
        }

        [Bindable(event="propertyChange")]
        public function get office():String
        {
            return (this._1019789636office);
        }

        public function set honor(_arg_1:String):void
        {
            var _local_2:Object = this._99462250honor;
            if (_local_2 !== _arg_1)
            {
                this._99462250honor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "honor", _local_2, _arg_1));
            };
        }

        public function set roleImg(_arg_1:int):void
        {
            var _local_2:Object = this._1376863085roleImg;
            if (_local_2 !== _arg_1)
            {
                this._1376863085roleImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "roleImg", _local_2, _arg_1));
            };
        }

        private function _TopInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.server;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label1.text = _arg_1;
            }, "_TopInfo_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.alliance;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label2.text = _arg_1;
            }, "_TopInfo_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label3.text = _arg_1;
            }, "_TopInfo_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.office;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label4.text = _arg_1;
            }, "_TopInfo_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.gameCoins;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label5.text = _arg_1;
            }, "_TopInfo_Label5.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.ranking;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label6.text = _arg_1;
            }, "_TopInfo_Label6.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.allianceLvLArr.getItemAt(this.roleImg));
            }, function (_arg_1:Object):void
            {
                _TopInfo_Image7.source = _arg_1;
            }, "_TopInfo_Image7.source");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.role;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label7.text = _arg_1;
            }, "_TopInfo_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label8.text = _arg_1;
            }, "_TopInfo_Label8.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label9.text = _arg_1;
            }, "_TopInfo_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.gift;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TopInfo_Label10.text = _arg_1;
            }, "_TopInfo_Label10.text");
            result[10] = binding;
            return (result);
        }

        public function set role(_arg_1:String):void
        {
            var _local_2:Object = this._3506294role;
            if (_local_2 !== _arg_1)
            {
                this._3506294role = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "role", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui

