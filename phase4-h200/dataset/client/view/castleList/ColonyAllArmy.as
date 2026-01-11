// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ColonyAllArmy

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.beans.CastleBean;
    import mx.controls.Image;
    import com.evony.common.beans.TroopStrBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import view.ui.MyHRule;
    import mx.controls.VRule;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.factory.ImageManager;
    import com.evony.common.constants.TFConstants;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.colony.ColonyLevyeRespone;
    import flash.utils.getDefinitionByName;
    import com.evony.client.action.ActionFactory;
    import mx.events.FlexEvent;
    import com.evony.common.module.colony.OverviewColonyCastleRespone;
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

    public class ColonyAllArmy extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ColonyAllArmy_Label10:Label;
        public var _ColonyAllArmy_Label11:Label;
        public var _ColonyAllArmy_Label12:Label;
        public var _ColonyAllArmy_Label13:Label;
        public var _ColonyAllArmy_Label14:Label;
        public var _ColonyAllArmy_Label15:Label;
        public var _ColonyAllArmy_Label16:Label;
        public var _ColonyAllArmy_Label17:Label;
        public var _ColonyAllArmy_Label18:Label;
        public var _ColonyAllArmy_Label19:Label;
        private var _1197684682colonyBean:ColonyBean;
        public var _ColonyAllArmy_Label2:Label;
        public var _ColonyAllArmy_Label20:Label;
        public var _ColonyAllArmy_Label21:Label;
        public var _ColonyAllArmy_Label23:Label;
        public var _ColonyAllArmy_Label25:Label;
        public var _ColonyAllArmy_Label22:Label;
        public var _ColonyAllArmy_Label24:Label;
        public var _ColonyAllArmy_Label26:Label;
        private var _113836232castleBean:CastleBean;
        private var endStr:String;
        public var _ColonyAllArmy_Image2:Image;
        public var _ColonyAllArmy_Image3:Image;
        public var _ColonyAllArmy_Image4:Image;
        public var _ColonyAllArmy_Image5:Image;
        public var _ColonyAllArmy_Image6:Image;
        public var _ColonyAllArmy_Image9:Image;
        public var _ColonyAllArmy_Image7:Image;
        public var _ColonyAllArmy_Image8:Image;
        private var actionType:String;
        private var _1825239910currCastleBean:CastleBean;
        private var _1464563117_troop:TroopStrBean;
        public var _ColonyAllArmy_Image10:Image;
        public var _ColonyAllArmy_Image11:Image;
        public var _ColonyAllArmy_Image12:Image;
        public var _ColonyAllArmy_Image13:Image;
        public var _ColonyAllArmy_Label1:Label;
        public var _ColonyAllArmy_Label3:Label;
        public var _ColonyAllArmy_Label4:Label;
        public var _ColonyAllArmy_Label5:Label;
        public var _ColonyAllArmy_Label6:Label;
        public var _ColonyAllArmy_Label7:Label;
        public var _ColonyAllArmy_Label8:Label;
        public var _ColonyAllArmy_Label9:Label;

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
                                "width":210,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ColonyAllArmy_Label1",
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
                            this.left = "210";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":22,
                                "styleName":"textBackGroundFillColor",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "width":210,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ColonyAllArmy_Label2",
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
                            this.horizontalCenter = "0";
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
                                "y":264
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
                                "y":242
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
                                "y":220
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
                                "y":198
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
                                "y":176
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
                                "y":154
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
                                "y":132
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
                                "y":110
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
                                "y":88
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
                                "y":66
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
                                "y":44
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
                            this.horizontalCenter = "0";
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
                                "y":22,
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label4",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label6",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label8",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label10",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label12",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label13",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label14",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label15",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label16",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label17",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label18",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label19",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label20",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label21",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label22",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label23",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label24",
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
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ColonyAllArmy_Image13",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "10";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":25,
                                                                    "height":25
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
                                                        "width":180,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label25",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "30";
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
                                                        "width":210,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ColonyAllArmy_Label26",
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

        public function ColonyAllArmy()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___ColonyAllArmy_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyAllArmy._watcherSetupUtil = _arg_1;
        }


        public function set setColony(_arg_1:ColonyBean):void
        {
            this.colonyBean = _arg_1;
        }

        public function init():void
        {
        }

        private function _ColonyAllArmy_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("兵种");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label1.text = _arg_1;
            }, "_ColonyAllArmy_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label2.text = _arg_1;
            }, "_ColonyAllArmy_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_PEASANTS));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image2.source = _arg_1;
            }, "_ColonyAllArmy_Image2.source");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民夫");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label3.text = _arg_1;
            }, "_ColonyAllArmy_Label3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._troop.peasants;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label4.text = _arg_1;
            }, "_ColonyAllArmy_Label4.text");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_MILITIA));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image3.source = _arg_1;
            }, "_ColonyAllArmy_Image3.source");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("义兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label5.text = _arg_1;
            }, "_ColonyAllArmy_Label5.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.militia;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label6.text = _arg_1;
            }, "_ColonyAllArmy_Label6.text");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_SCOUTER));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image4.source = _arg_1;
            }, "_ColonyAllArmy_Image4.source");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("斥候");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label7.text = _arg_1;
            }, "_ColonyAllArmy_Label7.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.scouter;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label8.text = _arg_1;
            }, "_ColonyAllArmy_Label8.text");
            result[10] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_PIKEMAN));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image5.source = _arg_1;
            }, "_ColonyAllArmy_Image5.source");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("枪兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label9.text = _arg_1;
            }, "_ColonyAllArmy_Label9.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.pikemen;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label10.text = _arg_1;
            }, "_ColonyAllArmy_Label10.text");
            result[13] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_SWORDSMEN));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image6.source = _arg_1;
            }, "_ColonyAllArmy_Image6.source");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("刀盾兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label11.text = _arg_1;
            }, "_ColonyAllArmy_Label11.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.swordsmen;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label12.text = _arg_1;
            }, "_ColonyAllArmy_Label12.text");
            result[16] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_ARCHER));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image7.source = _arg_1;
            }, "_ColonyAllArmy_Image7.source");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("弓箭手");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label13.text = _arg_1;
            }, "_ColonyAllArmy_Label13.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.archer;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label14.text = _arg_1;
            }, "_ColonyAllArmy_Label14.text");
            result[19] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_LIGHTCAVALRY));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image8.source = _arg_1;
            }, "_ColonyAllArmy_Image8.source");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("轻骑兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label15.text = _arg_1;
            }, "_ColonyAllArmy_Label15.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.lightCavalry;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label16.text = _arg_1;
            }, "_ColonyAllArmy_Label16.text");
            result[22] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_HEAVYCAVALRY));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image9.source = _arg_1;
            }, "_ColonyAllArmy_Image9.source");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铁骑兵");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label17.text = _arg_1;
            }, "_ColonyAllArmy_Label17.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.heavyCavalry;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label18.text = _arg_1;
            }, "_ColonyAllArmy_Label18.text");
            result[25] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_CARRIAGE));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image10.source = _arg_1;
            }, "_ColonyAllArmy_Image10.source");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("辎重车");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label19.text = _arg_1;
            }, "_ColonyAllArmy_Label19.text");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.carriage;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label20.text = _arg_1;
            }, "_ColonyAllArmy_Label20.text");
            result[28] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_BALLISTA));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image11.source = _arg_1;
            }, "_ColonyAllArmy_Image11.source");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("车弩");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label21.text = _arg_1;
            }, "_ColonyAllArmy_Label21.text");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _troop.ballista;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label22.text = _arg_1;
            }, "_ColonyAllArmy_Label22.text");
            result[31] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_BATTERINGRAM));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image12.source = _arg_1;
            }, "_ColonyAllArmy_Image12.source");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("冲车");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label23.text = _arg_1;
            }, "_ColonyAllArmy_Label23.text");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._troop.batteringRam;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label24.text = _arg_1;
            }, "_ColonyAllArmy_Label24.text");
            result[34] = binding;
            binding = new Binding(this, function ():Object
            {
                return (ImageManager.getTroopSmallLogo(TFConstants.T_CATAPULT));
            }, function (_arg_1:Object):void
            {
                _ColonyAllArmy_Image13.source = _arg_1;
            }, "_ColonyAllArmy_Image13.source");
            result[35] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("投石车");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label25.text = _arg_1;
            }, "_ColonyAllArmy_Label25.text");
            result[36] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._troop.catapult;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyAllArmy_Label26.text = _arg_1;
            }, "_ColonyAllArmy_Label26.text");
            result[37] = binding;
            return (result);
        }

        private function _ColonyAllArmy_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("兵种");
            _local_1 = Lang.msg("数量");
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_PEASANTS);
            _local_1 = Lang.msg("民夫");
            _local_1 = this._troop.peasants;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_MILITIA);
            _local_1 = Lang.msg("义兵");
            _local_1 = _troop.militia;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_SCOUTER);
            _local_1 = Lang.msg("斥候");
            _local_1 = _troop.scouter;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_PIKEMAN);
            _local_1 = Lang.msg("枪兵");
            _local_1 = _troop.pikemen;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_SWORDSMEN);
            _local_1 = Lang.msg("刀盾兵");
            _local_1 = _troop.swordsmen;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_ARCHER);
            _local_1 = Lang.msg("弓箭手");
            _local_1 = _troop.archer;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_LIGHTCAVALRY);
            _local_1 = Lang.msg("轻骑兵");
            _local_1 = _troop.lightCavalry;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_HEAVYCAVALRY);
            _local_1 = Lang.msg("铁骑兵");
            _local_1 = _troop.heavyCavalry;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_CARRIAGE);
            _local_1 = Lang.msg("辎重车");
            _local_1 = _troop.carriage;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_BALLISTA);
            _local_1 = Lang.msg("车弩");
            _local_1 = _troop.ballista;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_BATTERINGRAM);
            _local_1 = Lang.msg("冲车");
            _local_1 = this._troop.batteringRam;
            _local_1 = ImageManager.getTroopSmallLogo(TFConstants.T_CATAPULT);
            _local_1 = Lang.msg("投石车");
            _local_1 = this._troop.catapult;
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

        [Bindable(event="propertyChange")]
        private function get _troop():TroopStrBean
        {
            return (this._1464563117_troop);
        }

        private function levyResponse(_arg_1:ColonyLevyeRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.colonyBean.isCanLevy = false;
                AlertWin.show(((((actionType + String(_arg_1.amount)) + " ") + _arg_1.armyType) + endStr));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg, null);
            };
        }

        public function set setCastleBean(_arg_1:CastleBean):void
        {
            this.castleBean = _arg_1;
        }

        override public function initialize():void
        {
            var target:ColonyAllArmy;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyAllArmy_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ColonyAllArmyWatcherSetupUtil");
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

        public function set setTroopStrBean(_arg_1:TroopStrBean):void
        {
            this._troop = _arg_1;
        }

        private function set _troop(_arg_1:TroopStrBean):void
        {
            var _local_2:Object = this._1464563117_troop;
            if (_local_2 !== _arg_1)
            {
                this._1464563117_troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_troop", _local_2, _arg_1));
            };
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

        private function reduceArmaments():void
        {
            actionType = "You have disarmed ";
            endStr = " in the city.";
            ActionFactory.getInstance().getColonyCommands().reduceArmaments(castleBean.id, colonyBean.castleId, levyResponse);
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

        private function levyArmy():void
        {
            actionType = "You have drafted ";
            endStr = " from the city.";
            ActionFactory.getInstance().getColonyCommands().levyArmy(castleBean.id, colonyBean.castleId, levyResponse);
        }

        private function getColonyInfo():void
        {
            ActionFactory.getInstance().getColonyCommands().overviewColonialCastle(castleBean.id, this.colonyBean.castleId, setColonyInfo);
        }

        public function ___ColonyAllArmy_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        private function setColonyInfo(_arg_1:OverviewColonyCastleRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                currCastleBean = null;
                currCastleBean = _arg_1.castleBean;
                _troop = currCastleBean.strTroop;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get colonyBean():ColonyBean
        {
            return (this._1197684682colonyBean);
        }


    }
}//package view.castleList

