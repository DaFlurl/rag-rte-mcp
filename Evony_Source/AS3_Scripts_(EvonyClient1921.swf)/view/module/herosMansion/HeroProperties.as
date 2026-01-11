// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.HeroProperties

package view.module.herosMansion
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.controls.dataGridClasses.DataGridColumn;
    import view.module.accouter.AccoutContainer;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.HeroBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import flash.events.MouseEvent;
    import mx.binding.BindingManager;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import view.module.accouter.ControlUI;
    import view.module.accouter.OneSetUI;
    import com.evony.Lang;
    import com.evony.common.constants.HeroConstants;
    import com.evony.Context;
    import mx.binding.Binding;
    import com.evony.common.constants.EquipmentTech;
    import mx.events.FlexEvent;
    import com.evony.eum.ItemEumDefine;
    import com.evony.common.beans.EquipmentBean;
    import mx.core.ClassFactory;
    import mx.controls.dataGridClasses.DataGridItemRenderer;
    import com.evony.util.UIUtil;
    import view.ui.AddFundWin;
    import com.evony.common.beans.ItemBean;
    import mx.managers.PopUpManager;
    import com.evony.client.response.ResponseDispatcher;
    import view.AllWindows;
    import view.module.shop.ShopWin;
    import flash.external.ExternalInterface;
    import flash.utils.getDefinitionByName;
    import view.module.playerInfo.UnlockSecurityCode;
    import view.module.playerInfo.ApplySecurityCode;
    import com.evony.factory.ItemManager;
    import flash.display.Bitmap;
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
    import view.module.playerInfo.*;
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

    public class HeroProperties extends Canvas implements IBindingClient 
    {

        public static var instance:HeroProperties;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _619105883heroName:Text;
        private var _1738047212heroLoyalty:Text;
        private var _1872071749playerBtn:Button;
        private var _212831741releaseBtn2:Button;
        public var _HeroProperties_DataGridColumn1:DataGridColumn;
        public var _HeroProperties_DataGridColumn2:DataGridColumn;
        public var _HeroProperties_DataGridColumn3:DataGridColumn;
        private var _200657540aheroWisdom:Text;
        private var _1984284331aheroInterior:Text;
        private var _1949225773updateBtn:Button;
        private var _855009604heroPotential:Text;
        private var _733258336accoutCont12:AccoutContainer;
        private var _733258304accoutCont01:AccoutContainer;
        private var _849486778fireBtn:Button;
        private var _1249813276addPower:Button;
        public var _HeroProperties_Image12:Image;
        public var _HeroProperties_Image13:Image;
        public var _HeroProperties_Label1:Label;
        public var _HeroProperties_Label2:Label;
        public var _HeroProperties_Label3:Label;
        public var _HeroProperties_Label4:Label;
        public var _HeroProperties_Label5:Label;
        public var _HeroProperties_Label6:Label;
        public var _HeroProperties_Label7:Label;
        public var _HeroProperties_Label8:Label;
        public var _HeroProperties_Label9:Label;
        private var _733258311accoutCont08:AccoutContainer;
        private var _2045167673persuadeSurrenderBtn:Button;
        private var _286603322accoutCont08_2:AccoutContainer;
        private var _414832531addPointCounts:int = 0;
        private var _1406124884buyStrBook:Button;
        private var _733258308accoutCont05:AccoutContainer;
        private var _105236930addWisdom:Button;
        private var _1990025787heroListDG:DataGrid;
        public var _HeroProperties_Button16:Button;
        public var _HeroProperties_Button19:Button;
        private var _2010139349heroPower:Text;
        private var _1990034853heroWisdom:Text;
        private var _526945657heroEquipEnable:Boolean;
        private var _733258305accoutCont02:AccoutContainer;
        private var _1757268313heroDesStr:String;
        private var _733258309accoutCont06:AccoutContainer;
        private var _1101236847remainPoints:int;
        private var _2014132310heroLevel:Text;
        private var _619157576heroList:ArrayCollection;
        private var _733258312accoutCont09:AccoutContainer;
        private var _2112150940heroSalary:Text;
        private var _1315418018exitBtn:Button;
        private var curCallAlert:String = "";
        private var _402887146aheroPower:Text;
        private var _742881793changeNameBtn:Button;
        private var _25093378addPointCounts1:int = 0;
        private var _379604938heroInterior:Text;
        private var _733258334accoutCont10:AccoutContainer;
        private var _733258306accoutCont03:AccoutContainer;
        private var _286627347accoutCont12_2:AccoutContainer;
        private var _802860780oneSetChange:Button;
        private var _25093377addPointCounts2:int = 0;
        private var _403873423addInterior:Button;
        private var _619252845heroIcon:Image;
        public var _HeroProperties_Canvas4:Canvas;
        private var _1125153597washBtn:Button;
        private var _25093376addPointCounts3:int = 0;
        private var _286627348accoutCont12_3:AccoutContainer;
        public var _HeroProperties_Label10:Label;
        public var _HeroProperties_Label11:Label;
        public var _HeroProperties_Label12:Label;
        public var _HeroProperties_Label13:Label;
        private var _811312001heroMes:HeroBean;
        private var _348630820submitBtn:Button;
        private var _733258335accoutCont11:AccoutContainer;
        private var _286604283accoutCont09_2:AccoutContainer;
        private var _733258307accoutCont04:AccoutContainer;
        private var _1517155115releaseBtn:Button;
        private var _1237898500heroExperience:Text;
        private var _1978644800buyExpBook:Button;
        private var _733258310accoutCont07:AccoutContainer;
        private var _1621978433awardBtn:Button;

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
                                    "id":"_HeroProperties_Label1",
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
                        "type":DataGrid,
                        "id":"heroListDG",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "33";
                            this.bottom = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "width":425,
                                "height":127,
                                "columns":[_HeroProperties_DataGridColumn1_i(), _HeroProperties_DataGridColumn2_i(), _HeroProperties_DataGridColumn3_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"exitBtn",
                        "events":{"click":"__exitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "62";
                            this.left = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":425,
                                "height":138,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"heroIcon",
                                    "events":{"complete":"__heroIcon_complete"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "height":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.right = "220";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"PropertyName1",
                                            "y":10,
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroName",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "205";
                                        this.right = "8";
                                        this.top = "10";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "120";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "y":34
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.right = "220";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"PropertyName1",
                                            "y":39,
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroLevel",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "205";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":78,
                                            "styleName":"PropertyValue1",
                                            "y":38,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "120";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "y":60
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.right = "220";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"PropertyName1",
                                            "y":65,
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroExperience",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "205";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyValue1",
                                            "width":171,
                                            "y":64,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"persuadeSurrenderBtn",
                                    "events":{"click":"__persuadeSurrenderBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "110";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"fireBtn",
                                    "events":{"click":"__fireBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "110";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"releaseBtn",
                                    "events":{"click":"__releaseBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "133";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":113,
                                            "styleName":"b95",
                                            "height":20
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"changeNameBtn",
                                    "events":{"click":"__changeNameBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.left = "133";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"b95",
                                            "y":113
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"releaseBtn2",
                                    "events":{"click":"__releaseBtn2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.left = "133";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"b95",
                                            "y":113
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"buyExpBook",
                                    "events":{"click":"__buyExpBook_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "27";
                                        this.bottom = "58";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"",
                                            "styleName":"addBtn",
                                            "width":12,
                                            "height":12
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"awardBtn",
                                    "events":{"click":"__awardBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"b95",
                                            "y":91,
                                            "x":285
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"updateBtn",
                                    "events":{"click":"__updateBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":21,
                                            "styleName":"b95",
                                            "y":114,
                                            "x":285
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"washBtn",
                                    "events":{"click":"__washBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.left = "133";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"b95",
                                            "y":91
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"playerBtn",
                                    "events":{"click":"__playerBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"b95",
                                            "y":39,
                                            "x":305
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "204";
                            this.left = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":425,
                                "height":160,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "5";
                                        this.right = "115";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":90
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroLoyalty",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.right = "16";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"PropertyValue1",
                                            "width":100,
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "200";
                                        this.top = "26";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/Controls/tab/line.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label6",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "31";
                                        this.right = "115";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":90
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"aheroPower",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "16";
                                        this.top = "31";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "200";
                                        this.top = "52";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/Controls/tab/line.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label7",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "57";
                                        this.right = "115";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":90
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"aheroWisdom",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "16";
                                        this.top = "57";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label8",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "5";
                                        this.right = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroInterior",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "105";
                                        this.top = "5";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "26";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label9",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "31";
                                        this.right = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroPower",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "105";
                                        this.top = "31";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "52";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label10",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "57";
                                        this.right = "312";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":110
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroWisdom",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "105";
                                        this.top = "57";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "78";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label11",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "83";
                                        this.right = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroPotential",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "83";
                                        this.left = "105";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "104";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label12",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "109";
                                        this.right = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"aheroInterior",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "105";
                                        this.top = "109";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "130";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"buyStrBook",
                                    "events":{"click":"__buyStrBook_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "114";
                                        this.left = "200";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"",
                                            "styleName":"addBtn",
                                            "height":12,
                                            "width":14.2
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroProperties_Label13",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "135";
                                        this.right = "320";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":24,
                                            "styleName":"PropertyName1",
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"heroSalary",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "105";
                                        this.top = "132";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "styleName":"PropertyValue1",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"addInterior",
                                    "events":{"click":"__addInterior_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "189";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":17,
                                            "height":17,
                                            "styleName":"addAttibuteButton",
                                            "y":6
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"addWisdom",
                                    "events":{"click":"__addWisdom_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.left = "189";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":17,
                                            "height":17,
                                            "styleName":"addAttibuteButton",
                                            "y":58
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"addPower",
                                    "events":{"click":"__addPower_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.left = "189";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":17,
                                            "height":17,
                                            "styleName":"addAttibuteButton",
                                            "y":32
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroProperties_Button16",
                                    "events":{"click":"___HeroProperties_Button16_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "33";
                                        this.bottom = "34";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":21,
                                            "styleName":"b135"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"submitBtn",
                                    "events":{"click":"__submitBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "33";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":21,
                                            "styleName":"b135"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"_HeroProperties_Canvas4",
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
                                    "events":{"complete":"___HeroProperties_Image11_complete"},
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
                                    "id":"_HeroProperties_Image12",
                                    "events":{"complete":"___HeroProperties_Image12_complete"},
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
                                            "y":17
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
                                            "y":60
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
                                            "y":109
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
                                            "y":156
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
                                            "y":203
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
                                            "y":250
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
                                            "y":297
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
                                            "y":373
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
                                            "y":17
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
                                            "y":60
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
                                            "y":109
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
                                            "y":156
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
                                            "y":203
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
                                            "y":250
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
                                            "y":297
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
                                            "y":343
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_HeroProperties_Image13",
                                    "events":{"click":"___HeroProperties_Image13_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":20,
                                            "y":10,
                                            "width":34,
                                            "height":44,
                                            "source":"images/icon/hero/replenish.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "15";
                                        this.horizontalGap = 5;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":405,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"oneSetChange",
                                                "events":{"click":"__oneSetChange_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b95"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_HeroProperties_Button19",
                                                "events":{"click":"___HeroProperties_Button19_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
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

        public function HeroProperties()
        {
            mx_internal::_document = this;
            this.width = 820;
            this.height = 530;
            this.addEventListener("creationComplete", ___HeroProperties_Canvas1_creationComplete);
            this.addEventListener("mouseDown", ___HeroProperties_Canvas1_mouseDown);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HeroProperties._watcherSetupUtil = _arg_1;
        }


        private function set addPointCounts3(_arg_1:int):void
        {
            var _local_2:Object = this._25093376addPointCounts3;
            if (_local_2 !== _arg_1)
            {
                this._25093376addPointCounts3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addPointCounts3", _local_2, _arg_1));
            };
        }

        private function takeOfAll():void
        {
            ActionFactory.getInstance().getEquipmentCommands().TakeOffAllEquipmenttech(heroMes.id, takeOfAllResponse);
        }

        private function onTryGetSeizedHero(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.heroEquipEnable = true;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg, null);
            };
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont09_2():AccoutContainer
        {
            return (this._286604283accoutCont09_2);
        }

        [Bindable(event="propertyChange")]
        public function get aheroPower():Text
        {
            return (this._402887146aheroPower);
        }

        private function set addPointCounts2(_arg_1:int):void
        {
            var _local_2:Object = this._25093377addPointCounts2;
            if (_local_2 !== _arg_1)
            {
                this._25093377addPointCounts2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addPointCounts2", _local_2, _arg_1));
            };
        }

        public function __persuadeSurrenderBtn_click(_arg_1:MouseEvent):void
        {
            onClickBtn(_arg_1);
        }

        private function _HeroProperties_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HeroProperties_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 160;
            BindingManager.executeBindings(this, "_HeroProperties_DataGridColumn1", _HeroProperties_DataGridColumn1);
            return (_local_1);
        }

        public function set releaseBtn2(_arg_1:Button):void
        {
            var _local_2:Object = this._212831741releaseBtn2;
            if (_local_2 !== _arg_1)
            {
                this._212831741releaseBtn2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "releaseBtn2", _local_2, _arg_1));
            };
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

        [Bindable(event="propertyChange")]
        public function get releaseBtn2():Button
        {
            return (this._212831741releaseBtn2);
        }

        public function set heroExperience(_arg_1:Text):void
        {
            var _local_2:Object = this._1237898500heroExperience;
            if (_local_2 !== _arg_1)
            {
                this._1237898500heroExperience = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroExperience", _local_2, _arg_1));
            };
        }

        public function set oneSetChange(_arg_1:Button):void
        {
            var _local_2:Object = this._802860780oneSetChange;
            if (_local_2 !== _arg_1)
            {
                this._802860780oneSetChange = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "oneSetChange", _local_2, _arg_1));
            };
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

        public function __playerBtn_click(_arg_1:MouseEvent):void
        {
            onClickBtn(_arg_1);
        }

        public function __washBtn_click(_arg_1:MouseEvent):void
        {
            onClickBtn(_arg_1);
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

        private function set addPointCounts1(_arg_1:int):void
        {
            var _local_2:Object = this._25093378addPointCounts1;
            if (_local_2 !== _arg_1)
            {
                this._25093378addPointCounts1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addPointCounts1", _local_2, _arg_1));
            };
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

        public function set _heroList(_arg_1:ArrayCollection):void
        {
            heroList = _arg_1;
        }

        public function ___HeroProperties_Image12_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get persuadeSurrenderBtn():Button
        {
            return (this._2045167673persuadeSurrenderBtn);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont08_2():AccoutContainer
        {
            return (this._286603322accoutCont08_2);
        }

        public function set changeNameBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._742881793changeNameBtn;
            if (_local_2 !== _arg_1)
            {
                this._742881793changeNameBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changeNameBtn", _local_2, _arg_1));
            };
        }

        private function onAddProperty(_arg_1:MouseEvent):void
        {
            var _local_2:RegExp = /[0-9]*/;
            switch (_arg_1.target)
            {
                case this.addInterior:
                    addPointCounts1++;
                    heroInterior.text = ((heroMes.managementBuffAdded == 0) ? String(fixNumber((Number(_local_2.exec(heroInterior.text)) + 1))) : String(((fixNumber((Number(_local_2.exec(heroInterior.text)) + 1)) + "+") + Math.round((((int(_local_2.exec(heroInterior.text)) + 1) * heroMes.managementBuffAdded) / 100)))));
                    break;
                case this.addPower:
                    addPointCounts2++;
                    heroPower.text = ((heroMes.powerBuffAdded == 0) ? String(fixNumber((Number(_local_2.exec(heroPower.text)) + 1))) : String(((fixNumber((Number(_local_2.exec(heroPower.text)) + 1)) + "+") + Math.round((((int(_local_2.exec(heroPower.text)) + 1) * heroMes.powerBuffAdded) / 100)))));
                    break;
                case this.addWisdom:
                    addPointCounts3++;
                    heroWisdom.text = ((heroMes.stratagemBuffAdded == 0) ? String(fixNumber((Number(_local_2.exec(heroWisdom.text)) + 1))) : String(((fixNumber((Number(_local_2.exec(heroWisdom.text)) + 1)) + "+") + Math.round((((int(_local_2.exec(heroWisdom.text)) + 1) * heroMes.stratagemBuffAdded) / 100)))));
                    break;
            };
            addPointCounts++;
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
        public function get accoutCont09():AccoutContainer
        {
            return (this._733258312accoutCont09);
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont06():AccoutContainer
        {
            return (this._733258309accoutCont06);
        }

        public function __addPower_click(_arg_1:MouseEvent):void
        {
            onAddProperty(_arg_1);
        }

        public function set submitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._348630820submitBtn;
            if (_local_2 !== _arg_1)
            {
                this._348630820submitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "submitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroListDG():DataGrid
        {
            return (this._1990025787heroListDG);
        }

        public function __oneSetChange_click(_arg_1:MouseEvent):void
        {
            setAllShow();
        }

        public function set heroPower(_arg_1:Text):void
        {
            var _local_2:Object = this._2010139349heroPower;
            if (_local_2 !== _arg_1)
            {
                this._2010139349heroPower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPower", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroWisdom():Text
        {
            return (this._1990034853heroWisdom);
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

        private function mouseDownHandler(_arg_1:MouseEvent):void
        {
            if (ControlUI.instance.visible)
            {
                ControlUI.instance.onClose();
            };
            if (OneSetUI.instance.visible)
            {
                OneSetUI.instance.onClose();
            };
        }

        [Bindable(event="propertyChange")]
        public function get changeNameBtn():Button
        {
            return (this._742881793changeNameBtn);
        }

        [Bindable(event="propertyChange")]
        public function get exitBtn():Button
        {
            return (this._1315418018exitBtn);
        }

        [Bindable(event="propertyChange")]
        public function get fireBtn():Button
        {
            return (this._849486778fireBtn);
        }

        [Bindable(event="propertyChange")]
        public function get heroSalary():Text
        {
            return (this._2112150940heroSalary);
        }

        private function onAddPoint(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("保存成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __fireBtn_click(_arg_1:MouseEvent):void
        {
            onClickBtn(_arg_1);
        }

        public function set persuadeSurrenderBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2045167673persuadeSurrenderBtn;
            if (_local_2 !== _arg_1)
            {
                this._2045167673persuadeSurrenderBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "persuadeSurrenderBtn", _local_2, _arg_1));
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
                remainPoints = _arg_1.remainPoint;
                heroDesStr = ((("<b>" + _arg_1.name) + "</b> \n") + "this is the heroDescription!");
                refreshInitData();
            }
            else
            {
                heroMes = null;
                addPointCounts = 0;
                heroEquipEnable = false;
                oneSetChange.enabled = false;
                setAccountBean();
                return;
            };
            addPointCounts = 0;
            addPointCounts1 = 0;
            addPointCounts2 = 0;
            addPointCounts3 = 0;
            setAccountBean();
            if (((heroMes.status == HeroConstants.HERO_SEIZED_STATU) || (heroMes.status == HeroConstants.HERO_FLEE_STATU)))
            {
                heroEquipEnable = false;
            }
            else
            {
                heroEquipEnable = true;
            };
        }

        private function onHeroLevelUp(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set washBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1125153597washBtn;
            if (_local_2 !== _arg_1)
            {
                this._1125153597washBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "washBtn", _local_2, _arg_1));
            };
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

        public function set accoutCont09(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258312accoutCont09;
            if (_local_2 !== _arg_1)
            {
                this._733258312accoutCont09 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont09", _local_2, _arg_1));
            };
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

        private function onHireChief():void
        {
            var hireChiefResponse:Function;
            hireChiefResponse = function (_arg_1:CommandResponse):void
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            ActionFactory.getInstance().getHeroCommand().promoteToChief(Context.getInstance().getCurCastle().id, heroMes.id, hireChiefResponse);
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

        public function set accoutCont05(_arg_1:AccoutContainer):void
        {
            var _local_2:Object = this._733258308accoutCont05;
            if (_local_2 !== _arg_1)
            {
                this._733258308accoutCont05 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutCont05", _local_2, _arg_1));
            };
        }

        public function set buyExpBook(_arg_1:Button):void
        {
            var _local_2:Object = this._1978644800buyExpBook;
            if (_local_2 !== _arg_1)
            {
                this._1978644800buyExpBook = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyExpBook", _local_2, _arg_1));
            };
        }

        private function _HeroProperties_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("英雄属性");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label1.text = _arg_1;
            }, "_HeroProperties_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroList);
            }, function (_arg_1:Object):void
            {
                heroListDG.dataProvider = _arg_1;
            }, "heroListDG.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_DataGridColumn1.headerText = _arg_1;
            }, "_HeroProperties_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_DataGridColumn2.headerText = _arg_1;
            }, "_HeroProperties_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_DataGridColumn3.headerText = _arg_1;
            }, "_HeroProperties_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (heroMes.logoUrl);
            }, function (_arg_1:Object):void
            {
                heroIcon.source = _arg_1;
            }, "heroIcon.source");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("名字") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label2.text = _arg_1;
            }, "_HeroProperties_Label2.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroName.text = _arg_1;
            }, "heroName.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("等级") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label3.text = _arg_1;
            }, "_HeroProperties_Label3.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.level;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroLevel.text = _arg_1;
            }, "heroLevel.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("经验") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label4.text = _arg_1;
            }, "_HeroProperties_Label4.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.experience + "/") + heroMes.upgradeExp);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroExperience.text = _arg_1;
            }, "heroExperience.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招降");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                persuadeSurrenderBtn.label = _arg_1;
            }, "persuadeSurrenderBtn.label");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroMes.status == HeroConstants.HERO_SEIZED_STATU);
            }, function (_arg_1:Boolean):void
            {
                persuadeSurrenderBtn.visible = _arg_1;
            }, "persuadeSurrenderBtn.visible");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("解雇");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                fireBtn.label = _arg_1;
            }, "fireBtn.label");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            }, function (_arg_1:Boolean):void
            {
                fireBtn.visible = _arg_1;
            }, "fireBtn.visible");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.isHero == 2));
            }, function (_arg_1:Boolean):void
            {
                fireBtn.enabled = _arg_1;
            }, "fireBtn.enabled");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("释放");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                releaseBtn.label = _arg_1;
            }, "releaseBtn.label");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.isHero == 2));
            }, function (_arg_1:Boolean):void
            {
                releaseBtn.enabled = _arg_1;
            }, "releaseBtn.enabled");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroMes.status == HeroConstants.HERO_SEIZED_STATU);
            }, function (_arg_1:Boolean):void
            {
                releaseBtn.visible = _arg_1;
            }, "releaseBtn.visible");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("改名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                changeNameBtn.label = _arg_1;
            }, "changeNameBtn.label");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(this.heroMes.status == HeroConstants.HERO_SEIZED_STATU)) && (heroMes.isHero == 0));
            }, function (_arg_1:Boolean):void
            {
                changeNameBtn.enabled = _arg_1;
            }, "changeNameBtn.enabled");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("释放");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                releaseBtn2.label = _arg_1;
            }, "releaseBtn2.label");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroMes.status == HeroConstants.HERO_SEIZED_STATU);
            }, function (_arg_1:Boolean):void
            {
                releaseBtn2.visible = _arg_1;
            }, "releaseBtn2.visible");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.isHero == 2));
            }, function (_arg_1:Boolean):void
            {
                releaseBtn2.enabled = _arg_1;
            }, "releaseBtn2.enabled");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            }, function (_arg_1:Boolean):void
            {
                buyExpBook.enabled = _arg_1;
            }, "buyExpBook.enabled");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("赏赐");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                awardBtn.label = _arg_1;
            }, "awardBtn.label");
            result[26] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            }, function (_arg_1:Boolean):void
            {
                awardBtn.enabled = _arg_1;
            }, "awardBtn.enabled");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("升级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                updateBtn.label = _arg_1;
            }, "updateBtn.label");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((heroMes.experience - heroMes.upgradeExp) >= 0);
            }, function (_arg_1:Boolean):void
            {
                updateBtn.enabled = _arg_1;
            }, "updateBtn.enabled");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("洗点");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                washBtn.label = _arg_1;
            }, "washBtn.label");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            }, function (_arg_1:Boolean):void
            {
                washBtn.enabled = _arg_1;
            }, "washBtn.enabled");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("个人信息");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                playerBtn.label = _arg_1;
            }, "playerBtn.label");
            result[32] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroMes.isHero == 1);
            }, function (_arg_1:Boolean):void
            {
                playerBtn.enabled = _arg_1;
            }, "playerBtn.enabled");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("忠诚") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label5.text = _arg_1;
            }, "_HeroProperties_Label5.text");
            result[34] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.isHero == 2) ? "--" : heroMes.loyalty);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroLoyalty.text = _arg_1;
            }, "heroLoyalty.text");
            result[35] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("统帅") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label6.text = _arg_1;
            }, "_HeroProperties_Label6.text");
            result[36] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.leadership;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                aheroPower.text = _arg_1;
            }, "aheroPower.text");
            result[37] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("速度") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label7.text = _arg_1;
            }, "_HeroProperties_Label7.text");
            result[38] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.speed;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                aheroWisdom.text = _arg_1;
            }, "aheroWisdom.text");
            result[39] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("内政") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label8.text = _arg_1;
            }, "_HeroProperties_Label8.text");
            result[40] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.managementBuffAdded == 0) ? fixNumber((heroMes.management + heroMes.politics)) : String(((fixNumber((heroMes.management + heroMes.politics)) + ((heroMes.managementBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.management + heroMes.politics) * heroMes.managementBuffAdded) / 100)))));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroInterior.text = _arg_1;
            }, "heroInterior.text");
            result[41] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("勇武") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label9.text = _arg_1;
            }, "_HeroProperties_Label9.text");
            result[42] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.powerBuffAdded == 0) ? fixNumber((heroMes.power + heroMes.attack)) : String(((fixNumber((heroMes.power + heroMes.attack)) + ((heroMes.powerBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.power + heroMes.attack) * heroMes.powerBuffAdded) / 100)))));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroPower.text = _arg_1;
            }, "heroPower.text");
            result[43] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("智谋") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label10.text = _arg_1;
            }, "_HeroProperties_Label10.text");
            result[44] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.stratagemBuffAdded == 0) ? fixNumber((heroMes.stratagem + heroMes.intelligence)) : String(((fixNumber((heroMes.stratagem + heroMes.intelligence)) + ((heroMes.stratagemBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.stratagem + heroMes.intelligence) * heroMes.stratagemBuffAdded) / 100)))));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroWisdom.text = _arg_1;
            }, "heroWisdom.text");
            result[45] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("潜力") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label11.text = _arg_1;
            }, "_HeroProperties_Label11.text");
            result[46] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (heroMes.remainPoint - this.addPointCounts);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroPotential.text = _arg_1;
            }, "heroPotential.text");
            result[47] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("体力") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label12.text = _arg_1;
            }, "_HeroProperties_Label12.text");
            result[48] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.stamina + "/") + heroMes.maxStrength);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                aheroInterior.text = _arg_1;
            }, "aheroInterior.text");
            result[49] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("俸禄") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Label13.text = _arg_1;
            }, "_HeroProperties_Label13.text");
            result[50] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((heroMes.isHero == 2) ? "--" : (heroMes.level * 20));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                heroSalary.text = _arg_1;
            }, "heroSalary.text");
            result[51] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((heroMes.remainPoint - this.addPointCounts) > 0);
            }, function (_arg_1:Boolean):void
            {
                addInterior.enabled = _arg_1;
            }, "addInterior.enabled");
            result[52] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((heroMes.remainPoint - this.addPointCounts) > 0);
            }, function (_arg_1:Boolean):void
            {
                addWisdom.enabled = _arg_1;
            }, "addWisdom.enabled");
            result[53] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((heroMes.remainPoint - this.addPointCounts) > 0);
            }, function (_arg_1:Boolean):void
            {
                addPower.enabled = _arg_1;
            }, "addPower.enabled");
            result[54] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任命城守");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Button16.label = _arg_1;
            }, "_HeroProperties_Button16.label");
            result[55] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroMes.status == HeroConstants.HERO_FREE_STATU);
            }, function (_arg_1:Boolean):void
            {
                _HeroProperties_Button16.enabled = _arg_1;
            }, "_HeroProperties_Button16.enabled");
            result[56] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("保存属性");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[57] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            }, function (_arg_1:Boolean):void
            {
                submitBtn.enabled = _arg_1;
            }, "submitBtn.enabled");
            result[58] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (heroEquipEnable);
            }, function (_arg_1:Boolean):void
            {
                _HeroProperties_Canvas4.enabled = _arg_1;
            }, "_HeroProperties_Canvas4.enabled");
            result[59] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((heroMes.sex) ? "images/EmbedImages/playInfo/heroMan.png" : "images/EmbedImages/playInfo/heroWoman.png");
            }, function (_arg_1:Object):void
            {
                _HeroProperties_Image12.source = _arg_1;
            }, "_HeroProperties_Image12.source");
            result[60] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_HEAD);
            }, function (_arg_1:int):void
            {
                accoutCont01.posId = _arg_1;
            }, "accoutCont01.posId");
            result[61] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_CHEST);
            }, function (_arg_1:int):void
            {
                accoutCont04.posId = _arg_1;
            }, "accoutCont04.posId");
            result[62] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_WEAPON_L);
            }, function (_arg_1:int):void
            {
                accoutCont12.posId = _arg_1;
            }, "accoutCont12.posId");
            result[63] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_SHIELD_L);
            }, function (_arg_1:int):void
            {
                accoutCont12_2.posId = _arg_1;
            }, "accoutCont12_2.posId");
            result[64] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_LEG_L);
            }, function (_arg_1:int):void
            {
                accoutCont12_3.posId = _arg_1;
            }, "accoutCont12_3.posId");
            result[65] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L);
            }, function (_arg_1:int):void
            {
                accoutCont09.posId = _arg_1;
            }, "accoutCont09.posId");
            result[66] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_RING_L);
            }, function (_arg_1:int):void
            {
                accoutCont08.posId = _arg_1;
            }, "accoutCont08.posId");
            result[67] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            }, function (_arg_1:int):void
            {
                accoutCont11.posId = _arg_1;
            }, "accoutCont11.posId");
            result[68] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_NECKLACE);
            }, function (_arg_1:int):void
            {
                accoutCont02.posId = _arg_1;
            }, "accoutCont02.posId");
            result[69] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_SHOULDERS);
            }, function (_arg_1:int):void
            {
                accoutCont03.posId = _arg_1;
            }, "accoutCont03.posId");
            result[70] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_BACK);
            }, function (_arg_1:int):void
            {
                accoutCont05.posId = _arg_1;
            }, "accoutCont05.posId");
            result[71] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_WRIST);
            }, function (_arg_1:int):void
            {
                accoutCont07.posId = _arg_1;
            }, "accoutCont07.posId");
            result[72] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_WAIST);
            }, function (_arg_1:int):void
            {
                accoutCont06.posId = _arg_1;
            }, "accoutCont06.posId");
            result[73] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R);
            }, function (_arg_1:int):void
            {
                accoutCont09_2.posId = _arg_1;
            }, "accoutCont09_2.posId");
            result[74] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_RING_R);
            }, function (_arg_1:int):void
            {
                accoutCont08_2.posId = _arg_1;
            }, "accoutCont08_2.posId");
            result[75] = binding;
            binding = new Binding(this, function ():int
            {
                return (EquipmentTech.EQUIPMENT_SLOT_FEET);
            }, function (_arg_1:int):void
            {
                accoutCont10.posId = _arg_1;
            }, "accoutCont10.posId");
            result[76] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("解除所有");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Image13.toolTip = _arg_1;
            }, "_HeroProperties_Image13.toolTip");
            result[77] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("一键换装");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                oneSetChange.label = _arg_1;
            }, "oneSetChange.label");
            result[78] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("一键换装提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                oneSetChange.toolTip = _arg_1;
            }, "oneSetChange.toolTip");
            result[79] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("购买宝物");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroProperties_Button19.label = _arg_1;
            }, "_HeroProperties_Button19.label");
            result[80] = binding;
            return (result);
        }

        public function __heroIcon_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set heroPotential(_arg_1:Text):void
        {
            var _local_2:Object = this._855009604heroPotential;
            if (_local_2 !== _arg_1)
            {
                this._855009604heroPotential = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroPotential", _local_2, _arg_1));
            };
        }

        public function set heroListDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1990025787heroListDG;
            if (_local_2 !== _arg_1)
            {
                this._1990025787heroListDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroListDG", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get accoutCont12():AccoutContainer
        {
            return (this._733258336accoutCont12);
        }

        public function set buyStrBook(_arg_1:Button):void
        {
            var _local_2:Object = this._1406124884buyStrBook;
            if (_local_2 !== _arg_1)
            {
                this._1406124884buyStrBook = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyStrBook", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get aheroInterior():Text
        {
            return (this._1984284331aheroInterior);
        }

        public function set fireBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._849486778fireBtn;
            if (_local_2 !== _arg_1)
            {
                this._849486778fireBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fireBtn", _local_2, _arg_1));
            };
        }

        public function ___HeroProperties_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onClickBtn(_arg_1:MouseEvent):void
        {
            var _local_2:* = "";
            switch (_arg_1.target)
            {
                case this.persuadeSurrenderBtn:
                    _local_2 = (((heroMes.itemId) && (heroMes.itemAmount > 0)) ? ((Lang.msg("招降英雄{0}需要花费黄金{1}", heroMes.name, (heroMes.level * 1000)) + ", ") + Lang.msg("需要{0}{1}", heroMes.itemAmount, ItemEumDefine.getItemEum(heroMes.itemId).name)) : Lang.msg("招降英雄{0}需要花费黄金{1}", heroMes.name, (heroMes.level * 1000)));
                    curCallAlert = "persuadeSurrender";
                    break;
                case this.fireBtn:
                    _local_2 = Lang.msg("确定解雇英雄{0}", heroMes.name);
                    curCallAlert = "fireHero";
                    break;
                case this.washBtn:
                    _local_2 = Lang.msg("需要花费洗髓丹{0}", Math.ceil((heroMes.level / 10)));
                    curCallAlert = "washHero";
                    break;
                case this.releaseBtn:
                    _local_2 = Lang.msg("确定释放英雄{0}", heroMes.name);
                    curCallAlert = "releaseHero";
                    break;
                case this.releaseBtn2:
                    _local_2 = Lang.msg("确定释放英雄{0}", heroMes.name);
                    curCallAlert = "releaseHero";
                    break;
                case this.playerBtn:
                    HeroDescribeWin.show(heroMes.infro);
                    return;
            };
            AlertWin.show(_local_2, onAlertClose, Lang.msg("确定"), Lang.msg("取消"), this);
        }

        [Bindable(event="propertyChange")]
        private function get remainPoints():int
        {
            return (this._1101236847remainPoints);
        }

        public function set heroWisdom(_arg_1:Text):void
        {
            var _local_2:Object = this._1990034853heroWisdom;
            if (_local_2 !== _arg_1)
            {
                this._1990034853heroWisdom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroWisdom", _local_2, _arg_1));
            };
        }

        public function __buyStrBook_click(_arg_1:MouseEvent):void
        {
            addStr();
        }

        private function oneSetEnable():void
        {
            var _local_1:EquipmentBean;
            for each (_local_1 in heroMes.equipmentbeanArray)
            {
                if (_local_1.lv != 0)
                {
                    oneSetChange.enabled = true;
                    return;
                };
            };
            oneSetChange.enabled = false;
        }

        private function set heroDesStr(_arg_1:String):void
        {
            var _local_2:Object = this._1757268313heroDesStr;
            if (_local_2 !== _arg_1)
            {
                this._1757268313heroDesStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroDesStr", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        public function get awardBtn():Button
        {
            return (this._1621978433awardBtn);
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

        public function set heroSalary(_arg_1:Text):void
        {
            var _local_2:Object = this._2112150940heroSalary;
            if (_local_2 !== _arg_1)
            {
                this._2112150940heroSalary = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroSalary", _local_2, _arg_1));
            };
        }

        private function _HeroProperties_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = HeroProperties_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get updateBtn():Button
        {
            return (this._1949225773updateBtn);
        }

        private function refreshInitData():void
        {
            if (heroMes != null)
            {
                heroInterior.text = ((heroMes.managementBuffAdded == 0) ? fixNumber((heroMes.management + heroMes.politics)) : String(((fixNumber((heroMes.management + heroMes.politics)) + ((heroMes.managementBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.management + heroMes.politics) * heroMes.managementBuffAdded) / 100)))));
                heroPower.text = ((heroMes.powerBuffAdded == 0) ? fixNumber((heroMes.power + heroMes.attack)) : String(((fixNumber((heroMes.power + heroMes.attack)) + ((heroMes.powerBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.power + heroMes.attack) * heroMes.powerBuffAdded) / 100)))));
                heroWisdom.text = ((heroMes.stratagemBuffAdded == 0) ? fixNumber((heroMes.stratagem + heroMes.intelligence)) : String(((fixNumber((heroMes.stratagem + heroMes.intelligence)) + ((heroMes.stratagemBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.stratagem + heroMes.intelligence) * heroMes.stratagemBuffAdded) / 100)))));
            };
            oneSetEnable();
        }

        private function onAwardHero(_arg_1:MouseEvent):void
        {
            AwardHero.show(heroMes);
        }

        private function onHeroResetPoint(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _heroMes = heroMes;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
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

        private function doWashHero(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (UIUtil.checkItem("hero.reset.1", Math.ceil((heroMes.level / 10))))
                {
                    ActionFactory.getInstance().getHeroCommand().resetPoint(Context.getInstance().getCurCastle().id, heroMes.id);
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        public function __submitBtn_click(_arg_1:MouseEvent):void
        {
            onSubmitHero();
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

        public function __releaseBtn2_click(_arg_1:MouseEvent):void
        {
            onClickBtn(_arg_1);
        }

        public function set addInterior(_arg_1:Button):void
        {
            var _local_2:Object = this._403873423addInterior;
            if (_local_2 !== _arg_1)
            {
                this._403873423addInterior = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addInterior", _local_2, _arg_1));
            };
        }

        public function __addWisdom_click(_arg_1:MouseEvent):void
        {
            onAddProperty(_arg_1);
        }

        private function canUseGood(_arg_1:String="hero.reset.1"):Boolean
        {
            var _local_4:ItemBean;
            var _local_2:Boolean;
            var _local_3:int;
            while (_local_3 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_4 = Context.getInstance().getPlayerBean().getItems(_local_3);
                if (((_local_4.id == _arg_1) && (_local_4.count >= Math.ceil((this.heroMes.level / 10)))))
                {
                    _local_2 = true;
                    break;
                };
                _local_3++;
            };
            return (_local_2);
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

        private function set heroEquipEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._526945657heroEquipEnable;
            if (_local_2 !== _arg_1)
            {
                this._526945657heroEquipEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroEquipEnable", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroLoyalty():Text
        {
            return (this._1738047212heroLoyalty);
        }

        [Bindable(event="propertyChange")]
        public function get addPower():Button
        {
            return (this._1249813276addPower);
        }

        [Bindable(event="propertyChange")]
        private function get addPointCounts1():int
        {
            return (this._25093378addPointCounts1);
        }

        [Bindable(event="propertyChange")]
        private function get addPointCounts3():int
        {
            return (this._25093376addPointCounts3);
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

        private function onPersuadeSurrender():void
        {
        }

        public function set aheroWisdom(_arg_1:Text):void
        {
            var _local_2:Object = this._200657540aheroWisdom;
            if (_local_2 !== _arg_1)
            {
                this._200657540aheroWisdom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "aheroWisdom", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        public function get heroExperience():Text
        {
            return (this._1237898500heroExperience);
        }

        private function init():void
        {
            instance = this;
            PopUpManager.centerPopUp(this);
            this.x = (this.x - 150);
            this.y = (this.y - 40);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_FIRE_HERO, onFireHeroResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_ADD_POINT, onAddPoint);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_ADD_POINT2, onAddPoint);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_LEVEL_UP, onHeroLevelUp);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_RESET_POINT, onHeroResetPoint);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_RELEASE_HERO, onHeroRelease);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_TRY_GET_SEIZED_HERO, onTryGetSeizedHero);
            heroListDG.addEventListener(MouseEvent.CLICK, onHeroSelect);
            ResponseDispatcher.getInstance().addEventListener(ControlUI.EQUIPMENTUPDATE_EVENT, equipmengupdate);
        }

        public function ___HeroProperties_Image11_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get oneSetChange():Button
        {
            return (this._802860780oneSetChange);
        }

        [Bindable(event="propertyChange")]
        public function get releaseBtn():Button
        {
            return (this._1517155115releaseBtn);
        }

        private function onShopBtnClick():void
        {
            destroy();
            AllWindows.switchToFuncWindow(ShopWin.EVENT_SHOW);
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        public function set heroIcon(_arg_1:Image):void
        {
            var _local_2:Object = this._619252845heroIcon;
            if (_local_2 !== _arg_1)
            {
                this._619252845heroIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroIcon", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroPower():Text
        {
            return (this._2010139349heroPower);
        }

        private function set addPointCounts(_arg_1:int):void
        {
            var _local_2:Object = this._414832531addPointCounts;
            if (_local_2 !== _arg_1)
            {
                this._414832531addPointCounts = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addPointCounts", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get addPointCounts2():int
        {
            return (this._25093377addPointCounts2);
        }

        public function onAlertClose(_arg_1:Boolean):void
        {
            switch (_arg_1)
            {
                case true:
                    if (curCallAlert == "washHero")
                    {
                        if (canUseGood())
                        {
                            if (ExternalInterface.available)
                            {
                                ExternalInterface.call("callByIngameUse", "hero.reset.1", "Holy Water", "宝物", "20");
                            };
                            ActionFactory.getInstance().getHeroCommand().resetPoint(Context.getInstance().getCurCastle().id, heroMes.id);
                        }
                        else
                        {
                            AlertWin.show(Lang.msg("物品不足确定购买"), doWashHero, Lang.msg("确定"), Lang.msg("取消"));
                        };
                    }
                    else
                    {
                        if (curCallAlert == "fireHero")
                        {
                            ActionFactory.getInstance().getHeroCommand().fireHero(Context.getInstance().getCurCastle().id, heroMes.id);
                        }
                        else
                        {
                            if (curCallAlert == "releaseHero")
                            {
                                ActionFactory.getInstance().getHeroCommand().releaseHero(Context.getInstance().getCurCastle().id, heroMes.id);
                            }
                            else
                            {
                                if (curCallAlert == "persuadeSurrender")
                                {
                                    ActionFactory.getInstance().getHeroCommand().tryGetSeizedHero(Context.getInstance().getCurCastle().id, heroMes.id);
                                };
                            };
                        };
                    };
                    return;
                case false:
                    return;
            };
        }

        public function __updateBtn_click(_arg_1:MouseEvent):void
        {
            onUpgrade(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get buyExpBook():Button
        {
            return (this._1978644800buyExpBook);
        }

        public function set heroName(_arg_1:Text):void
        {
            var _local_2:Object = this._619105883heroName;
            if (_local_2 !== _arg_1)
            {
                this._619105883heroName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroName", _local_2, _arg_1));
            };
        }

        private function onUpgrade(_arg_1:MouseEvent):void
        {
            ActionFactory.getInstance().getHeroCommand().levelUp(Context.getInstance().getCurCastle().id, heroMes.id);
        }

        private function onHeroRelease(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (heroList.length > 0)
                {
                    this._heroMes = (heroList[0] as HeroBean);
                }
                else
                {
                    this._heroMes = null;
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg, null);
            };
        }

        public function set aheroInterior(_arg_1:Text):void
        {
            var _local_2:Object = this._1984284331aheroInterior;
            if (_local_2 !== _arg_1)
            {
                this._1984284331aheroInterior = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "aheroInterior", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get heroDesStr():String
        {
            return (this._1757268313heroDesStr);
        }

        public function __addInterior_click(_arg_1:MouseEvent):void
        {
            onAddProperty(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get buyStrBook():Button
        {
            return (this._1406124884buyStrBook);
        }

        [Bindable(event="propertyChange")]
        public function get heroPotential():Text
        {
            return (this._855009604heroPotential);
        }

        public function set heroLevel(_arg_1:Text):void
        {
            var _local_2:Object = this._2014132310heroLevel;
            if (_local_2 !== _arg_1)
            {
                this._2014132310heroLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get washBtn():Button
        {
            return (this._1125153597washBtn);
        }

        private function takeOfAllResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ResponseDispatcher.getInstance().dispatchEvent(new Event(ControlUI.EQUIPMENTUPDATE_EVENT));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
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

        private function onSubmitHero():void
        {
            var _local_1:RegExp = /[0-9]*/;
            ActionFactory.getInstance().getHeroCommand().addPoint2(Context.getInstance().getCurCastle().id, heroMes.id, this.addPointCounts1, this.addPointCounts2, this.addPointCounts3);
            this.addPointCounts = 0;
            this.addPointCounts1 = 0;
            this.addPointCounts2 = 0;
            this.addPointCounts3 = 0;
        }

        public function ___HeroProperties_Button19_click(_arg_1:MouseEvent):void
        {
            onShopBtnClick();
        }

        [Bindable(event="propertyChange")]
        private function get heroEquipEnable():Boolean
        {
            return (this._526945657heroEquipEnable);
        }

        public function set playerBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1872071749playerBtn;
            if (_local_2 !== _arg_1)
            {
                this._1872071749playerBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerBtn", _local_2, _arg_1));
            };
        }

        public function __releaseBtn_click(_arg_1:MouseEvent):void
        {
            onClickBtn(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get heroMes():HeroBean
        {
            return (this._811312001heroMes);
        }

        private function setAllShow():void
        {
            OneSetUI.show(heroMes.id);
        }

        public function set awardBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1621978433awardBtn;
            if (_local_2 !== _arg_1)
            {
                this._1621978433awardBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "awardBtn", _local_2, _arg_1));
            };
        }

        private function equipmengupdate(_arg_1:Event):void
        {
            this.setAccountBean();
        }

        private function _HeroProperties_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HeroProperties_DataGridColumn3 = _local_1;
            _local_1.dataField = "status";
            _local_1.width = 100;
            _local_1.itemRenderer = _HeroProperties_ClassFactory1_c();
            BindingManager.executeBindings(this, "_HeroProperties_DataGridColumn3", _HeroProperties_DataGridColumn3);
            return (_local_1);
        }

        public function ___HeroProperties_Canvas1_mouseDown(_arg_1:MouseEvent):void
        {
            mouseDownHandler(_arg_1);
        }

        override public function initialize():void
        {
            var target:HeroProperties;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HeroProperties_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_HeroPropertiesWatcherSetupUtil");
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

        public function ___HeroProperties_Image13_click(_arg_1:MouseEvent):void
        {
            takeOfAll();
        }

        public function set heroInterior(_arg_1:Text):void
        {
            var _local_2:Object = this._379604938heroInterior;
            if (_local_2 !== _arg_1)
            {
                this._379604938heroInterior = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroInterior", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get addInterior():Button
        {
            return (this._403873423addInterior);
        }

        [Bindable(event="propertyChange")]
        public function get heroIcon():Image
        {
            return (this._619252845heroIcon);
        }

        private function onExit():void
        {
            PopUpManager.removePopUp(this);
        }

        public function set addWisdom(_arg_1:Button):void
        {
            var _local_2:Object = this._105236930addWisdom;
            if (_local_2 !== _arg_1)
            {
                this._105236930addWisdom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addWisdom", _local_2, _arg_1));
            };
        }

        private function onChangeName(_arg_1:MouseEvent):void
        {
            HeroChangeName.show(heroMes);
        }

        [Bindable(event="propertyChange")]
        public function get heroLevel():Text
        {
            return (this._2014132310heroLevel);
        }

        [Bindable(event="propertyChange")]
        private function get addPointCounts():int
        {
            return (this._414832531addPointCounts);
        }

        [Bindable(event="propertyChange")]
        public function get heroName():Text
        {
            return (this._619105883heroName);
        }

        public function set updateBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1949225773updateBtn;
            if (_local_2 !== _arg_1)
            {
                this._1949225773updateBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "updateBtn", _local_2, _arg_1));
            };
        }

        private function onFireHeroResponse(_arg_1:CommandResponse):void
        {
            trace((this.name + " onFireHeroResponse "));
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (heroList.length > 0)
                {
                    this._heroMes = (heroList[0] as HeroBean);
                }
                else
                {
                    this._heroMes = null;
                    this.onExit();
                };
            }
            else
            {
                if (_arg_1.ok == -200)
                {
                    if (Context.getInstance().bLoginSecurityCode)
                    {
                        UnlockSecurityCode.show(8);
                    }
                    else
                    {
                        ApplySecurityCode.show(8);
                    };
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        public function set releaseBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1517155115releaseBtn;
            if (_local_2 !== _arg_1)
            {
                this._1517155115releaseBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "releaseBtn", _local_2, _arg_1));
            };
        }

        public function ___HeroProperties_Button16_click(_arg_1:MouseEvent):void
        {
            onHireChief();
        }

        private function onTreasure(_arg_1:MouseEvent):void
        {
            UseGoodItemStatus.show(heroMes);
        }

        private function setAccountBean():void
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:EquipmentBean;
            var _local_1:Array = [accoutCont01, accoutCont02, accoutCont03, accoutCont04, accoutCont05, accoutCont06, accoutCont07, accoutCont08, accoutCont08_2, accoutCont09, accoutCont09_2, accoutCont10, accoutCont11, accoutCont12, accoutCont12_2, accoutCont12_3];
            if (heroMes == null)
            {
                while (_local_3 < _local_1.length)
                {
                    _local_1[_local_3].setNull();
                    _local_3++;
                };
                return;
            };
            while (_local_2 < _local_1.length)
            {
                for each (_local_4 in this.heroMes.equipmentbeanArray)
                {
                    if (_local_4.heroPos == _local_1[_local_2].posId)
                    {
                        _local_1[_local_2].itemBean = _local_4;
                        _local_1[_local_2].setHeroId(heroMes.id);
                    };
                };
                _local_2++;
            };
        }

        private function addExp():void
        {
            AwardJewelry.show(ItemManager.heroExpItemArray, heroMes);
        }

        private function fixNumber(_arg_1:Number):String
        {
            var _local_2:String = _arg_1.toFixed(2);
            if (_local_2.indexOf(".00") != -1)
            {
                return (_arg_1.toFixed(0));
            };
            if (_local_2.lastIndexOf("0") == (_local_2.length - 1))
            {
                return (_arg_1.toFixed(1));
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        private function get heroList():ArrayCollection
        {
            return (this._619157576heroList);
        }

        private function _HeroProperties_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HeroProperties_DataGridColumn2 = _local_1;
            _local_1.dataField = "level";
            _local_1.width = 56;
            BindingManager.executeBindings(this, "_HeroProperties_DataGridColumn2", _HeroProperties_DataGridColumn2);
            return (_local_1);
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function set addPower(_arg_1:Button):void
        {
            var _local_2:Object = this._1249813276addPower;
            if (_local_2 !== _arg_1)
            {
                this._1249813276addPower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addPower", _local_2, _arg_1));
            };
        }

        private function addStr():void
        {
            AwardJewelry.show(ItemManager.heroStrItemArray, heroMes);
        }

        public function __buyExpBook_click(_arg_1:MouseEvent):void
        {
            addExp();
        }

        [Bindable(event="propertyChange")]
        public function get heroInterior():Text
        {
            return (this._379604938heroInterior);
        }

        public function set aheroPower(_arg_1:Text):void
        {
            var _local_2:Object = this._402887146aheroPower;
            if (_local_2 !== _arg_1)
            {
                this._402887146aheroPower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "aheroPower", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get playerBtn():Button
        {
            return (this._1872071749playerBtn);
        }

        [Bindable(event="propertyChange")]
        public function get addWisdom():Button
        {
            return (this._105236930addWisdom);
        }

        public function set heroLoyalty(_arg_1:Text):void
        {
            var _local_2:Object = this._1738047212heroLoyalty;
            if (_local_2 !== _arg_1)
            {
                this._1738047212heroLoyalty = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroLoyalty", _local_2, _arg_1));
            };
        }

        public function __awardBtn_click(_arg_1:MouseEvent):void
        {
            onAwardHero(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get aheroWisdom():Text
        {
            return (this._200657540aheroWisdom);
        }

        private function _HeroProperties_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("英雄属性");
            _local_1 = heroList;
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("等级");
            _local_1 = Lang.msg("状态");
            _local_1 = heroMes.logoUrl;
            _local_1 = (Lang.msg("名字") + ": ");
            _local_1 = heroMes.name;
            _local_1 = (Lang.msg("等级") + ": ");
            _local_1 = heroMes.level;
            _local_1 = (Lang.msg("经验") + ": ");
            _local_1 = ((heroMes.experience + "/") + heroMes.upgradeExp);
            _local_1 = Lang.msg("招降");
            _local_1 = (heroMes.status == HeroConstants.HERO_SEIZED_STATU);
            _local_1 = Lang.msg("解雇");
            _local_1 = (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            _local_1 = (!(heroMes.isHero == 2));
            _local_1 = Lang.msg("释放");
            _local_1 = (!(heroMes.isHero == 2));
            _local_1 = (heroMes.status == HeroConstants.HERO_SEIZED_STATU);
            _local_1 = Lang.msg("改名");
            _local_1 = ((!(this.heroMes.status == HeroConstants.HERO_SEIZED_STATU)) && (heroMes.isHero == 0));
            _local_1 = Lang.msg("释放");
            _local_1 = (heroMes.status == HeroConstants.HERO_SEIZED_STATU);
            _local_1 = (!(heroMes.isHero == 2));
            _local_1 = (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            _local_1 = Lang.msg("赏赐");
            _local_1 = (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            _local_1 = Lang.msg("升级");
            _local_1 = ((heroMes.experience - heroMes.upgradeExp) >= 0);
            _local_1 = Lang.msg("洗点");
            _local_1 = (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            _local_1 = Lang.msg("个人信息");
            _local_1 = (heroMes.isHero == 1);
            _local_1 = (Lang.msg("忠诚") + ": ");
            _local_1 = ((heroMes.isHero == 2) ? "--" : heroMes.loyalty);
            _local_1 = (Lang.msg("统帅") + ": ");
            _local_1 = heroMes.leadership;
            _local_1 = (Lang.msg("速度") + ": ");
            _local_1 = heroMes.speed;
            _local_1 = (Lang.msg("内政") + ": ");
            _local_1 = ((heroMes.managementBuffAdded == 0) ? fixNumber((heroMes.management + heroMes.politics)) : String(((fixNumber((heroMes.management + heroMes.politics)) + ((heroMes.managementBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.management + heroMes.politics) * heroMes.managementBuffAdded) / 100)))));
            _local_1 = (Lang.msg("勇武") + ": ");
            _local_1 = ((heroMes.powerBuffAdded == 0) ? fixNumber((heroMes.power + heroMes.attack)) : String(((fixNumber((heroMes.power + heroMes.attack)) + ((heroMes.powerBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.power + heroMes.attack) * heroMes.powerBuffAdded) / 100)))));
            _local_1 = (Lang.msg("智谋") + ": ");
            _local_1 = ((heroMes.stratagemBuffAdded == 0) ? fixNumber((heroMes.stratagem + heroMes.intelligence)) : String(((fixNumber((heroMes.stratagem + heroMes.intelligence)) + ((heroMes.stratagemBuffAdded > 0) ? "+" : "")) + Math.round((((heroMes.stratagem + heroMes.intelligence) * heroMes.stratagemBuffAdded) / 100)))));
            _local_1 = (Lang.msg("潜力") + ": ");
            _local_1 = (heroMes.remainPoint - this.addPointCounts);
            _local_1 = (Lang.msg("体力") + ": ");
            _local_1 = ((heroMes.stamina + "/") + heroMes.maxStrength);
            _local_1 = (Lang.msg("俸禄") + ": ");
            _local_1 = ((heroMes.isHero == 2) ? "--" : (heroMes.level * 20));
            _local_1 = ((heroMes.remainPoint - this.addPointCounts) > 0);
            _local_1 = ((heroMes.remainPoint - this.addPointCounts) > 0);
            _local_1 = ((heroMes.remainPoint - this.addPointCounts) > 0);
            _local_1 = Lang.msg("任命城守");
            _local_1 = (heroMes.status == HeroConstants.HERO_FREE_STATU);
            _local_1 = Lang.msg("保存属性");
            _local_1 = (!(heroMes.status == HeroConstants.HERO_SEIZED_STATU));
            _local_1 = heroEquipEnable;
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
            _local_1 = Lang.msg("解除所有");
            _local_1 = Lang.msg("一键换装");
            _local_1 = Lang.msg("一键换装提示");
            _local_1 = Lang.msg("购买宝物");
        }

        public function __changeNameBtn_click(_arg_1:MouseEvent):void
        {
            onChangeName(_arg_1);
        }

        public function destroy():void
        {
            if (AwardHero.instance)
            {
                PopUpManager.removePopUp(AwardHero.instance);
            }
            else
            {
                if (HeroChangeName.instance)
                {
                    PopUpManager.removePopUp(HeroChangeName.instance);
                };
            };
            PopUpManager.removePopUp(this);
        }

        public function onHeroSelect2(_arg_1:Object):void
        {
            _heroMes = HeroBean(_arg_1);
        }


    }
}//package view.module.herosMansion

