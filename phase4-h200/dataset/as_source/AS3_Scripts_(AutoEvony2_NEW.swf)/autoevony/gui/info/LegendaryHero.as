// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.LegendaryHero

package autoevony.gui.info
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Image;
    import mx.controls.CheckBox;
    import mx.controls.TextInput;
    import com.evony.common.beans.RandomHeroBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.controls.Spacer;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import autoevony.gui.MainScreen;
    import autoevony.common.Utils;
    import mx.events.FlexEvent;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.hero.RandomHeroResponse;
    import com.evony.common.constants.BuildingConstants;
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

    public class LegendaryHero extends Canvas implements IBindingClient 
    {

        private static const MAL_FACES:Array = new Array("faceA8.jpg", "faceA1.jpg", "faceA2.jpg", "faceA3.jpg", "faceA4.jpg", "faceA5.jpg", "faceA6.jpg", "faceA7.jpg", "faceA9.jpg", "faceA10.jpg", "faceA11.jpg", "faceA12.jpg", "faceA13.jpg", "faceA14.jpg", "faceA15.jpg", "faceA16.jpg", "faceA17.jpg", "faceA18.jpg", "faceA19.jpg", "faceA20.jpg", "faceA21.jpg", "faceA22.jpg", "faceA23.jpg", "faceA24.jpg", "faceA25.jpg");
        private static const FEM_FACES:Array = new Array("faceB1.jpg", "faceB2.jpg", "faceB3.jpg", "faceB4.jpg", "faceB5.jpg", "faceB6.jpg", "faceB7.jpg", "faceB8.jpg", "faceB9.jpg");
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var bCostSure:Boolean = true;
        private var _879022499txtCost:Label;
        public var _LegendaryHero_Image1:Image;
        private var _3052620chk2:CheckBox;
        public var _LegendaryHero_Label4:Label;
        public var _LegendaryHero_Label6:Label;
        public var _LegendaryHero_Label2:Label;
        private var _3052621chk3:CheckBox;
        private var _2096610540playername:TextInput;
        private var _1476239533randomHeroBean:RandomHeroBean;
        private var sex:int = 0;
        private var _553707709rollsLeft:Label;
        private var _3052619chk1:CheckBox;
        private var _571486424faceSource:String;
        private var faceIndex:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "3";
                            this.right = "3";
                            this.top = "3";
                            this.bottom = "3";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentHeight":30});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalGap = 0;
                                        this.paddingLeft = 20;
                                        this.paddingRight = 20;
                                        this.paddingTop = 25;
                                        this.paddingBottom = 25;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "bottom";
                                        this.borderColor = 0x222222;
                                        this.borderThickness = 1;
                                        this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                    this.verticalGap = 0;
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                    this.horizontalAlign = "center";
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.verticalGap = 0;
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                                this.horizontalAlign = "center";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 5;
                                                                            this.paddingLeft = 0;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 0;
                                                                            this.paddingBottom = 0;
                                                                            this.horizontalAlign = "right";
                                                                            this.verticalAlign = "middle";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 3;
                                                                                        this.verticalGap = 0;
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                        this.horizontalAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                    this.horizontalAlign = "right";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":90,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":19,
                                                                                                                    "text":"Politics:",
                                                                                                                    "styleName":"ParamgraphText1"
                                                                                                                });
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                    this.horizontalAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":35,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"_LegendaryHero_Label2",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.fontWeight = "bold";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":19,
                                                                                                                    "styleName":"ParamgraphText1"
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
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 3;
                                                                                        this.verticalGap = 0;
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                        this.horizontalAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                    this.horizontalAlign = "right";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":90,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":19,
                                                                                                                    "text":"Attack:",
                                                                                                                    "styleName":"ParamgraphText1"
                                                                                                                });
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                    this.horizontalAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":35,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"_LegendaryHero_Label4",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.fontWeight = "bold";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":19,
                                                                                                                    "styleName":"ParamgraphText1"
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
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 3;
                                                                                        this.verticalGap = 0;
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                        this.horizontalAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                    this.horizontalAlign = "right";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":90,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":19,
                                                                                                                    "text":"Intelligence:",
                                                                                                                    "styleName":"ParamgraphText1"
                                                                                                                });
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingBottom = 0;
                                                                                                    this.horizontalAlign = "left";
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":35,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"_LegendaryHero_Label6",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.fontWeight = "bold";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "height":19,
                                                                                                                    "styleName":"ParamgraphText1"
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
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 5;
                                                                            this.paddingLeft = 10;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 0;
                                                                            this.paddingBottom = 0;
                                                                            this.horizontalAlign = "left";
                                                                            this.verticalAlign = "middle";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 5;
                                                                                        this.verticalGap = 0;
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                        this.horizontalAlign = "left";
                                                                                        this.verticalAlign = "middle";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"chk1",
                                                                                                "events":{"change":"__chk1_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":19,
                                                                                                        "height":19,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Locked attributes do not change during the reset"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "height":19,
                                                                                                        "styleName":"ParamgraphText1",
                                                                                                        "text":"Lock",
                                                                                                        "toolTip":"Locked attributes do not change during the reset"
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 5;
                                                                                        this.verticalGap = 0;
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                        this.horizontalAlign = "left";
                                                                                        this.verticalAlign = "middle";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"chk2",
                                                                                                "events":{"change":"__chk2_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":19,
                                                                                                        "height":19,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Locked attributes do not change during the reset"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "height":19,
                                                                                                        "styleName":"ParamgraphText1",
                                                                                                        "text":"Lock",
                                                                                                        "toolTip":"Locked attributes do not change during the reset"
                                                                                                    });
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 5;
                                                                                        this.verticalGap = 0;
                                                                                        this.paddingLeft = 0;
                                                                                        this.paddingRight = 0;
                                                                                        this.paddingTop = 0;
                                                                                        this.paddingBottom = 0;
                                                                                        this.horizontalAlign = "left";
                                                                                        this.verticalAlign = "middle";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":CheckBox,
                                                                                                "id":"chk3",
                                                                                                "events":{"change":"__chk3_change"},
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "width":19,
                                                                                                        "height":19,
                                                                                                        "styleName":"REcheckBox",
                                                                                                        "toolTip":"Locked attributes do not change during the reset"
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "height":19,
                                                                                                        "styleName":"ParamgraphText1",
                                                                                                        "text":"Lock",
                                                                                                        "toolTip":"Locked attributes do not change during the reset"
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
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.verticalGap = 0;
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 10;
                                                                this.paddingBottom = 0;
                                                                this.horizontalAlign = "center";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"rollsLeft",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0xFFFFFF;
                                                                            this.fontWeight = "bold";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"ParamgraphText1"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.verticalGap = 0;
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                                this.horizontalAlign = "center";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"txtCost",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0xFF0000;
                                                                            this.fontWeight = "bold";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"ParamgraphText1",
                                                                                "text":""
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___LegendaryHero_Button1_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Roll New Attributes",
                                                                    "styleName":"REwinBtn",
                                                                    "toolTip":"Roll for new random attributes. All unlocked attributes will be permanently replaced."
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                    this.verticalGap = 0;
                                                    this.paddingLeft = 20;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                    this.horizontalAlign = "center";
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 8;
                                                                this.verticalGap = 0;
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                                this.horizontalAlign = "center";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___LegendaryHero_Button2_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"previousBtn"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "id":"_LegendaryHero_Image1",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":80,
                                                                                "height":80
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___LegendaryHero_Button3_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"nextBtn"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 5;
                                                                this.verticalGap = 0;
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 10;
                                                                this.paddingBottom = 10;
                                                                this.horizontalAlign = "center";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"ParamgraphText1",
                                                                                "text":"Name: "
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TextInput,
                                                                        "id":"playername"
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___LegendaryHero_Button4_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Recruit",
                                                                    "styleName":"REwinBtn",
                                                                    "toolTip":"Accept this hero with the above attributes.\r[requires and consumes 1 Legendary Ring]"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentHeight":70});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var faceArray:Array = new Array();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function LegendaryHero()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___LegendaryHero_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            LegendaryHero._watcherSetupUtil = _arg_1;
        }


        private function getIconUrl(_arg_1:String):String
        {
            return ("http://e2.eimg.us/" + _arg_1);
        }

        public function ___LegendaryHero_Button3_click(_arg_1:MouseEvent):void
        {
            this.changeFace(1);
        }

        public function __chk3_change(_arg_1:Event):void
        {
            this.onLockChange3();
        }

        private function _LegendaryHero_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.randomHeroBean.management;
            _local_1 = this.randomHeroBean.power;
            _local_1 = this.randomHeroBean.stratagem;
            _local_1 = (("You have " + this.randomHeroBean.resetcount) + "/3 free rolls remaining today.");
            _local_1 = this.getIconUrl(this.faceSource);
        }

        private function updateData(_arg_1:Object=null):void
        {
            ActionFactory.getInstance().getHeroCommand().GetRandomHero(this.onHeroResponse);
        }

        override public function initialize():void
        {
            var target:LegendaryHero;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._LegendaryHero_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_LegendaryHeroWatcherSetupUtil");
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

        public function set chk3(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._3052621chk3;
            if (_local_2 !== _arg_1)
            {
                this._3052621chk3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chk3", _local_2, _arg_1));
            };
        }

        public function set rollsLeft(_arg_1:Label):void
        {
            var _local_2:Object = this._553707709rollsLeft;
            if (_local_2 !== _arg_1)
            {
                this._553707709rollsLeft = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rollsLeft", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get faceSource():String
        {
            return (this._571486424faceSource);
        }

        private function init():void
        {
            if (MainScreen.getPlayer() == null)
            {
                Utils.callLater(1500, this.init);
                return;
            };
            this.sex = MainScreen.getPlayer().playerInfo.sex;
            this.faceArray = ((MAL_FACES.join(",") + ",") + FEM_FACES.join(",")).split(",");
            var _local_1:int;
            while (_local_1 < this.faceArray.length)
            {
                if (("images/icon/player/" + this.faceArray[_local_1].toString()) == MainScreen.getPlayer().playerInfo.faceUrl)
                {
                    this.faceIndex = _local_1;
                    break;
                };
                _local_1++;
            };
            this.faceSource = ("images/icon/player/" + this.faceArray[this.faceIndex]);
            this.playername.text = MainScreen.getPlayer().playerInfo.userName;
            addEventListener(FlexEvent.SHOW, this.updateData);
            addEventListener(Event.RENDER, this.onRender);
        }

        private function onItemSelectedOk(_arg_1:Boolean=false):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getHeroCommand().RetSetHeroAttri(this.chk1.selected, this.chk2.selected, this.chk3.selected, false, this.onHeroResponse);
            };
        }

        public function __chk2_change(_arg_1:Event):void
        {
            this.onLockChange2();
        }

        private function onOkayToRecruit(_arg_1:Boolean=false):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getHeroCommand().GenSaveRandomHero(MainScreen.getInstance().getSelectedCity().castle.id, this.playername.text, this.faceSource, this.onResponse);
                this.updateData();
            };
        }

        public function ___LegendaryHero_Button1_click(_arg_1:MouseEvent):void
        {
            this.onReset();
        }

        private function changeFace(_arg_1:int):void
        {
            this.faceIndex = (this.faceIndex + _arg_1);
            if (this.faceIndex < 0)
            {
                this.faceIndex = (this.faceArray.length - 1);
            }
            else
            {
                if (this.faceIndex >= this.faceArray.length)
                {
                    this.faceIndex = 0;
                };
            };
            this.faceSource = ("images/icon/player/" + this.faceArray[this.faceIndex]);
        }

        private function onReset():void
        {
            if (this.bCostSure)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (((this.rollsLeft.text + " ") + this.txtCost.text) + " Are you sure you want to roll new Stats?"), this.onItemSelectedOk, "Yes", "Cancel"));
            }
            else
            {
                this.onItemSelectedOk(true);
            };
        }

        public function ___LegendaryHero_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function set faceSource(_arg_1:String):void
        {
            var _local_2:Object = this._571486424faceSource;
            if (_local_2 !== _arg_1)
            {
                this._571486424faceSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "faceSource", _local_2, _arg_1));
            };
        }

        public function set chk1(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._3052619chk1;
            if (_local_2 !== _arg_1)
            {
                this._3052619chk1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chk1", _local_2, _arg_1));
            };
        }

        public function set chk2(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._3052620chk2;
            if (_local_2 !== _arg_1)
            {
                this._3052620chk2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chk2", _local_2, _arg_1));
            };
        }

        private function calCost():void
        {
            var _local_1:int;
            if (this.randomHeroBean.resetcount == 0)
            {
                _local_1 = 0;
                if (this.chk1.selected)
                {
                    _local_1++;
                };
                if (this.chk2.selected)
                {
                    _local_1++;
                };
                if (this.chk3.selected)
                {
                    _local_1++;
                };
                if (_local_1 == 2)
                {
                    this.txtCost.text = "This reset costs 40 coins and 40,000 gold.";
                }
                else
                {
                    if (_local_1 == 1)
                    {
                        this.txtCost.text = "This reset costs 20 coins and 20,000 gold.";
                    }
                    else
                    {
                        this.txtCost.text = "This reset costs 10 coins and 10,000 gold.";
                    };
                };
            }
            else
            {
                this.txtCost.text = "";
            };
        }

        [Bindable(event="propertyChange")]
        private function get randomHeroBean():RandomHeroBean
        {
            return (this._1476239533randomHeroBean);
        }

        [Bindable(event="propertyChange")]
        public function get rollsLeft():Label
        {
            return (this._553707709rollsLeft);
        }

        private function onResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != 1)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                MainScreen.getInstance()._cityPanel.setSelectedInfoTab("H");
            };
        }

        public function set txtCost(_arg_1:Label):void
        {
            var _local_2:Object = this._879022499txtCost;
            if (_local_2 !== _arg_1)
            {
                this._879022499txtCost = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtCost", _local_2, _arg_1));
            };
        }

        public function ___LegendaryHero_Button4_click(_arg_1:MouseEvent):void
        {
            this.onRecruit();
        }

        private function _LegendaryHero_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.randomHeroBean.management;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LegendaryHero_Label2.text = _arg_1;
            }, "_LegendaryHero_Label2.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.randomHeroBean.power;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LegendaryHero_Label4.text = _arg_1;
            }, "_LegendaryHero_Label4.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.randomHeroBean.stratagem;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LegendaryHero_Label6.text = _arg_1;
            }, "_LegendaryHero_Label6.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("You have " + this.randomHeroBean.resetcount) + "/3 free rolls remaining today.");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                rollsLeft.text = _arg_1;
            }, "rollsLeft.text");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.getIconUrl(this.faceSource));
            }, function (_arg_1:Object):void
            {
                _LegendaryHero_Image1.source = _arg_1;
            }, "_LegendaryHero_Image1.source");
            result[4] = binding;
            return (result);
        }

        public function ___LegendaryHero_Button2_click(_arg_1:MouseEvent):void
        {
            this.changeFace(-1);
        }

        [Bindable(event="propertyChange")]
        public function get chk3():CheckBox
        {
            return (this._3052621chk3);
        }

        [Bindable(event="propertyChange")]
        public function get chk1():CheckBox
        {
            return (this._3052619chk1);
        }

        public function __chk1_change(_arg_1:Event):void
        {
            this.onLockChange1();
        }

        private function onRender(_arg_1:Object):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            removeEventListener(Event.RENDER, this.onRender);
            this.updateData();
        }

        private function onHeroResponse(_arg_1:RandomHeroResponse):void
        {
            if (_arg_1.ok)
            {
                this.randomHeroBean = _arg_1.randomherobean;
                this.chk1.selected = this.randomHeroBean.lockmanagement;
                this.chk2.selected = this.randomHeroBean.lockpower;
                this.chk3.selected = this.randomHeroBean.lockstratagem;
                this.calCost();
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            };
        }

        [Bindable(event="propertyChange")]
        public function get txtCost():Label
        {
            return (this._879022499txtCost);
        }

        private function onRecruit():void
        {
            var _local_1:int = MainScreen.getInstance().getSelectedCity().cityManager.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION);
            if (_local_1 < 1)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "No Feasting Hall in current City. Please build one or select another City before recruiting."));
            }
            else
            {
                if (_local_1 <= MainScreen.getInstance().getSelectedCity().cityManager.heroes.length)
                {
                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "No available Feasting Hall spot in current City. Please upgrade or select another City before recruiting."));
                }
                else
                {
                    if (this.playername.text.length == 0)
                    {
                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "You must enter a valid name for your new hero before recruiting."));
                    }
                    else
                    {
                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Are you sure you want to recruit this hero?", this.onOkayToRecruit, "Yes", "Cancel"));
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get chk2():CheckBox
        {
            return (this._3052620chk2);
        }

        private function set randomHeroBean(_arg_1:RandomHeroBean):void
        {
            var _local_2:Object = this._1476239533randomHeroBean;
            if (_local_2 !== _arg_1)
            {
                this._1476239533randomHeroBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "randomHeroBean", _local_2, _arg_1));
            };
        }

        private function resetFaceArray():void
        {
            this.faceIndex = 0;
            if (this.sex != 0)
            {
                this.faceArray = FEM_FACES;
            }
            else
            {
                this.faceArray = MAL_FACES;
            };
            this.faceSource = ("images/icon/player/" + this.faceArray[this.faceIndex]);
        }

        private function onLockChange1():void
        {
            if (((this.chk2.selected) && (this.chk3.selected)))
            {
                this.chk1.selected = false;
                return;
            };
            this.calCost();
        }

        private function onLockChange2():void
        {
            if (((this.chk1.selected) && (this.chk3.selected)))
            {
                this.chk2.selected = false;
                return;
            };
            this.calCost();
        }

        private function onLockChange3():void
        {
            if (((this.chk1.selected) && (this.chk2.selected)))
            {
                this.chk3.selected = false;
                return;
            };
            this.calCost();
        }

        public function set playername(_arg_1:TextInput):void
        {
            var _local_2:Object = this._2096610540playername;
            if (_local_2 !== _arg_1)
            {
                this._2096610540playername = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playername", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get playername():TextInput
        {
            return (this._2096610540playername);
        }


    }
}//package autoevony.gui.info

