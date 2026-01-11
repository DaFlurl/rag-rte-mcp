// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ColonyResourceProduce

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.ColonyBean;
    import mx.controls.Label;
    import com.evony.common.beans.CastleResourceBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Image;
    import view.ui.MyHRule;
    import mx.controls.VRule;
    import mx.containers.VBox;
    import com.evony.util.EvonyImage;
    import mx.core.mx_internal;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.UIUtil;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
    import com.evony.common.module.colony.ColonyLevyeRespone;
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

    public class ColonyResourceProduce extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1825239910currCastleBean:CastleBean;
        private var _1197684682colonyBean:ColonyBean;
        public var _ColonyResourceProduce_Label10:Label;
        public var _ColonyResourceProduce_Label11:Label;
        public var _ColonyResourceProduce_Label12:Label;
        public var _ColonyResourceProduce_Label13:Label;
        public var _ColonyResourceProduce_Label14:Label;
        private var _113836232castleBean:CastleBean;
        public var _ColonyResourceProduce_Label16:Label;
        public var _ColonyResourceProduce_Label17:Label;
        public var _ColonyResourceProduce_Label18:Label;
        public var _ColonyResourceProduce_Label19:Label;
        public var _ColonyResourceProduce_Label15:Label;
        private var _250546835_resource:CastleResourceBean = null;
        private var levyType:String;
        private var isLogin:Boolean = false;
        public var _ColonyResourceProduce_Label5:Label;
        public var _ColonyResourceProduce_Label7:Label;
        public var _ColonyResourceProduce_Label9:Label;
        public var _ColonyResourceProduce_Label4:Label;
        public var _ColonyResourceProduce_Label6:Label;
        public var _ColonyResourceProduce_Label8:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "2";
                            this.left = "0";
                            this.right = "0";
                            this.verticalAlign = "middle";
                            this.horizontalAlign = "center";
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"doubleLineBlue",
                                "height":290
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"textBackGroundFillColor",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "width":160,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.fontSize = 13;
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"focusColor",
                                            "text":"Own",
                                            "y":2
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "160";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"textBackGroundFillColor",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "width":140,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.fontSize = 13;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"focusColor",
                                            "text":"Production",
                                            "y":2
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "300";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"textBackGroundFillColor",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "width":120,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.fontSize = 13;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"focusColor",
                                            "text":"Tributes pay",
                                            "y":2
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "160";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":25,
                                "source":"controls/DataGrid/separators.png"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.left = "300";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":25,
                                "source":"controls/DataGrid/separators.png"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":244
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":200
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":156
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":112
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.right = "2";
                            this.left = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":68
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MyHRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "2";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineHrule",
                                "y":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "160";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineVrule",
                                "width":1,
                                "height":260,
                                "y":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VRule,
                        "stylesFactory":function ():void
                        {
                            this.left = "300";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"lineVrule",
                                "width":1,
                                "height":260,
                                "y":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":34,
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":44,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":160,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"images/Controls/tab/icon_t1_1.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "60";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent2",
                                                                    "percentHeight":100
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":140,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":44,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":160,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"images/Controls/tab/icon_t1_2.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "60";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent2",
                                                                    "percentHeight":100
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":140,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":44,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":160,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"images/Controls/tab/icon_t1_3.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "60";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent2",
                                                                    "percentHeight":100
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":140,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":44,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":160,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"images/Controls/tab/icon_t1_4.png"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label13",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "60";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent2",
                                                                    "percentHeight":100
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":140,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label14",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label15",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":44,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":160,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":24,
                                                                    "height":24,
                                                                    "source":"images/Controls/Icon/CityInfo/icon_16.png"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label16",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "60";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent2",
                                                                    "percentHeight":100
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":140,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label17",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label18",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"tableContent2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":44,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":160,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":24,
                                                                    "height":24,
                                                                    "source":"images/Controls/Icon/CityInfo/icon_18.png"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyResourceProduce_Label19",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "60";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent2",
                                                                    "percentHeight":100
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":140,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"—",
                                                                    "styleName":"tableContent2"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"—",
                                                                    "styleName":"tableContent2"
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
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonyResourceProduce()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("render", ___ColonyResourceProduce_Canvas1_render);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyResourceProduce._watcherSetupUtil = _arg_1;
        }


        public function ___ColonyResourceProduce_Canvas1_render(_arg_1:Event):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get _resource():CastleResourceBean
        {
            return (this._250546835_resource);
        }

        private function init():void
        {
        }

        public function set setCastleBean(_arg_1:CastleBean):void
        {
            this.castleBean = _arg_1;
        }

        override public function initialize():void
        {
            var target:ColonyResourceProduce;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyResourceProduce_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ColonyResourceProduceWatcherSetupUtil");
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
        private function get currCastleBean():CastleBean
        {
            return (this._1825239910currCastleBean);
        }

        private function _ColonyResourceProduce_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = UIUtil.FormatInt(_resource.food.amount);
            _local_1 = UIUtil.FormatInt((_resource.food.increaseRate - _resource.troopCostFood));
            _local_1 = UIUtil.FormatInt(this.castleBean.resource.colonyFood);
            _local_1 = UIUtil.FormatInt(_resource.wood.amount);
            _local_1 = UIUtil.FormatInt(_resource.wood.increaseRate);
            _local_1 = UIUtil.FormatInt(this.castleBean.resource.colonyWood);
            _local_1 = UIUtil.FormatInt(_resource.stone.amount);
            _local_1 = UIUtil.FormatInt(_resource.stone.increaseRate);
            _local_1 = UIUtil.FormatInt(this.castleBean.resource.colonyStone);
            _local_1 = UIUtil.FormatInt(_resource.iron.amount);
            _local_1 = UIUtil.FormatInt(_resource.iron.increaseRate);
            _local_1 = UIUtil.FormatInt(this.castleBean.resource.colonyIron);
            _local_1 = UIUtil.FormatInt(_resource.gold);
            _local_1 = (this._resource.taxIncome - this._resource.herosSalary);
            _local_1 = UIUtil.FormatInt(this.castleBean.resource.colonyGold);
            _local_1 = _resource.curPopulation;
        }

        private function set castleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._113836232castleBean;
            if (_local_2 !== _arg_1)
            {
                this._113836232castleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleBean", _local_2, _arg_1));
            };
        }

        public function set setResourceBean(_arg_1:CastleResourceBean):void
        {
            this._resource = _arg_1;
        }

        private function set colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._1197684682colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._1197684682colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBean", _local_2, _arg_1));
            };
        }

        private function set currCastleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._1825239910currCastleBean;
            if (_local_2 !== _arg_1)
            {
                this._1825239910currCastleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currCastleBean", _local_2, _arg_1));
            };
        }

        private function getColonyInfo():void
        {
            ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(castleBean.id, this.colonyBean.castleId, setColonyInfo);
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        private function _ColonyResourceProduce_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.food.amount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label4.text = _arg_1;
            }, "_ColonyResourceProduce_Label4.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt((_resource.food.increaseRate - _resource.troopCostFood));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label5.text = _arg_1;
            }, "_ColonyResourceProduce_Label5.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.castleBean.resource.colonyFood);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label6.text = _arg_1;
            }, "_ColonyResourceProduce_Label6.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.wood.amount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label7.text = _arg_1;
            }, "_ColonyResourceProduce_Label7.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.wood.increaseRate);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label8.text = _arg_1;
            }, "_ColonyResourceProduce_Label8.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.castleBean.resource.colonyWood);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label9.text = _arg_1;
            }, "_ColonyResourceProduce_Label9.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.stone.amount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label10.text = _arg_1;
            }, "_ColonyResourceProduce_Label10.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.stone.increaseRate);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label11.text = _arg_1;
            }, "_ColonyResourceProduce_Label11.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.castleBean.resource.colonyStone);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label12.text = _arg_1;
            }, "_ColonyResourceProduce_Label12.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.iron.amount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label13.text = _arg_1;
            }, "_ColonyResourceProduce_Label13.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.iron.increaseRate);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label14.text = _arg_1;
            }, "_ColonyResourceProduce_Label14.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.castleBean.resource.colonyIron);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label15.text = _arg_1;
            }, "_ColonyResourceProduce_Label15.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(_resource.gold);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label16.text = _arg_1;
            }, "_ColonyResourceProduce_Label16.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this._resource.taxIncome - this._resource.herosSalary);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label17.text = _arg_1;
            }, "_ColonyResourceProduce_Label17.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = UIUtil.FormatInt(this.castleBean.resource.colonyGold);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label18.text = _arg_1;
            }, "_ColonyResourceProduce_Label18.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _resource.curPopulation;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyResourceProduce_Label19.text = _arg_1;
            }, "_ColonyResourceProduce_Label19.text");
            result[15] = binding;
            return (result);
        }

        private function setColonyInfo(_arg_1:OverviewColonyCastleRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                currCastleBean = null;
                currCastleBean = _arg_1.castleBean;
                _resource = currCastleBean.resource;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function levyPopulation():void
        {
            levyType = "Population redeployed!";
            ActionFactory.getInstance().getColonyCommands().levyPopulation(castleBean.id, this.colonyBean.castleId, levyResponse);
        }

        private function set _resource(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._250546835_resource;
            if (_local_2 !== _arg_1)
            {
                this._250546835_resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_resource", _local_2, _arg_1));
            };
        }

        private function levyResponse(_arg_1:ColonyLevyeRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.colonyBean.isCanLevy = false;
                AlertWin.show(((String(_arg_1.amount) + " amount of ") + levyType));
                getColonyInfo();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg, null);
            };
        }

        [Bindable(event="propertyChange")]
        private function get colonyBean():ColonyBean
        {
            return (this._1197684682colonyBean);
        }

        private function levyFood():void
        {
            levyType = "Food Levied!";
            ActionFactory.getInstance().getColonyCommands().levyFood(castleBean.id, this.colonyBean.castleId, levyResponse);
        }

        private function levyTaxes():void
        {
            levyType = "Gold imposed!";
            ActionFactory.getInstance().getColonyCommands().levyTaxes(castleBean.id, this.colonyBean.castleId, levyResponse);
        }

        public function set setColony(_arg_1:ColonyBean):void
        {
            this.colonyBean = _arg_1;
            this.isLogin = false;
        }


    }
}//package view.castleList

