// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.newarmy.NewArmyWin;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            NewArmyWin.watcherSetupUtil = new (_autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[70] = new PropertyWatcher("heros", {"propertyChange":true}, [_arg_3[18]], _arg_2);
            _arg_4[113] = new PropertyWatcher("travelTime", {"propertyChange":true}, [_arg_3[34], _arg_3[33]], _arg_2);
            _arg_4[111] = new PropertyWatcher("foodNeeded", {"propertyChange":true}, [_arg_3[32]], _arg_2);
            _arg_4[67] = new PropertyWatcher("savedTroopCfg", {"propertyChange":true}, [_arg_3[15]], _arg_2);
            _arg_4[69] = new PropertyWatcher("missionTypeArray", {"propertyChange":true}, [_arg_3[17]], _arg_2);
            _arg_4[7] = new PropertyWatcher("_tInputW", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[8] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[9] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[3] = new PropertyWatcher("maxDispatchLimit", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[114] = new PropertyWatcher("camptTime", {"propertyChange":true}, [_arg_3[34], _arg_3[33]], _arg_2);
            _arg_4[25] = new PropertyWatcher("_tInputCata", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[26] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[27] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[68] = new PropertyWatcher("quickCoords", {"propertyChange":true}, [_arg_3[16]], _arg_2);
            _arg_4[13] = new PropertyWatcher("_tInputP", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[14] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[15] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[1] = new PropertyWatcher("fieldId", {"propertyChange":true}, [_arg_3[0], _arg_3[31]], _arg_2);
            _arg_4[34] = new PropertyWatcher("_tInputR", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[35] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[36] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[10] = new PropertyWatcher("_tInputS", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[11] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[12] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[28] = new PropertyWatcher("_tInputT", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[29] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[30] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[108] = new PropertyWatcher("_yInput", {"propertyChange":true}, [_arg_3[31]], _arg_2);
            _arg_4[109] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[31]], null);
            _arg_4[31] = new PropertyWatcher("_tInputB", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[32] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[33] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[19] = new PropertyWatcher("_tInputA", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[20] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[21] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[22] = new PropertyWatcher("_tInputC", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[23] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[24] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[71] = new PropertyWatcher("selectedHero", {"propertyChange":true}, [_arg_3[19], _arg_3[20]], _arg_2);
            _arg_4[72] = new PropertyWatcher("id", {"propertyChange":true}, [_arg_3[19], _arg_3[20]], null);
            _arg_4[43] = new PropertyWatcher("troop", {"propertyChange":true}, [_arg_3[3], _arg_3[4], _arg_3[5], _arg_3[6], _arg_3[7], _arg_3[8], _arg_3[9], _arg_3[10], _arg_3[11], _arg_3[12], _arg_3[13], _arg_3[14]], _arg_2);
            _arg_4[66] = new PropertyWatcher("catapult", {"propertyChange":true}, [_arg_3[14]], null);
            _arg_4[54] = new PropertyWatcher("archer", {"propertyChange":true}, [_arg_3[8]], null);
            _arg_4[44] = new PropertyWatcher("peasants", {"propertyChange":true}, [_arg_3[3]], null);
            _arg_4[62] = new PropertyWatcher("ballista", {"propertyChange":true}, [_arg_3[12]], null);
            _arg_4[60] = new PropertyWatcher("carriage", {"propertyChange":true}, [_arg_3[11]], null);
            _arg_4[48] = new PropertyWatcher("scouter", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[58] = new PropertyWatcher("heavyCavalry", {"propertyChange":true}, [_arg_3[10]], null);
            _arg_4[46] = new PropertyWatcher("militia", {"propertyChange":true}, [_arg_3[4]], null);
            _arg_4[56] = new PropertyWatcher("lightCavalry", {"propertyChange":true}, [_arg_3[9]], null);
            _arg_4[52] = new PropertyWatcher("swordsmen", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[50] = new PropertyWatcher("pikemen", {"propertyChange":true}, [_arg_3[6]], null);
            _arg_4[64] = new PropertyWatcher("batteringRam", {"propertyChange":true}, [_arg_3[13]], null);
            _arg_4[41] = new PropertyWatcher("availableRallySlots", {"propertyChange":true}, [_arg_3[2]], _arg_2);
            _arg_4[81] = new PropertyWatcher("_rInputW", {"propertyChange":true}, [_arg_3[22]], _arg_2);
            _arg_4[82] = new PropertyWatcher("rInput", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[83] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[22]], null);
            _arg_4[106] = new PropertyWatcher("_xInput", {"propertyChange":true}, [_arg_3[31]], _arg_2);
            _arg_4[107] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[31]], null);
            _arg_4[84] = new PropertyWatcher("_rInputS", {"propertyChange":true}, [_arg_3[22]], _arg_2);
            _arg_4[85] = new PropertyWatcher("rInput", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[86] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[22]], null);
            _arg_4[75] = new PropertyWatcher("_rInputG", {"propertyChange":true}, [_arg_3[22]], _arg_2);
            _arg_4[76] = new PropertyWatcher("rInput", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[77] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[22]], null);
            _arg_4[92] = new PropertyWatcher("resource", {"propertyChange":true}, [_arg_3[23], _arg_3[25], _arg_3[24], _arg_3[27], _arg_3[26]], _arg_2);
            _arg_4[95] = new PropertyWatcher("wood", {"propertyChange":true}, [_arg_3[24]], null);
            _arg_4[93] = new PropertyWatcher("food", {"propertyChange":true}, [_arg_3[23]], null);
            _arg_4[97] = new PropertyWatcher("stone", {"propertyChange":true}, [_arg_3[25]], null);
            _arg_4[101] = new PropertyWatcher("gold", {"propertyChange":true}, [_arg_3[27]], null);
            _arg_4[99] = new PropertyWatcher("iron", {"propertyChange":true}, [_arg_3[26]], null);
            _arg_4[87] = new PropertyWatcher("_rInputI", {"propertyChange":true}, [_arg_3[22]], _arg_2);
            _arg_4[88] = new PropertyWatcher("rInput", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[89] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[22]], null);
            _arg_4[37] = new PropertyWatcher("_tInputCp", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[38] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[39] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[4] = new PropertyWatcher("_tInputWo", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[5] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[6] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[16] = new PropertyWatcher("_tInputSw", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[17] = new PropertyWatcher("tInput", {"propertyChange":true}, [_arg_3[1]], null);
            _arg_4[18] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[1]], null);
            _arg_4[102] = new PropertyWatcher("localArmiesData", {"propertyChange":true}, [_arg_3[28]], _arg_2);
            _arg_4[78] = new PropertyWatcher("_rInputF", {"propertyChange":true}, [_arg_3[22]], _arg_2);
            _arg_4[79] = new PropertyWatcher("rInput", {"propertyChange":true}, [_arg_3[22]], null);
            _arg_4[80] = new PropertyWatcher("text", {
                "change":false,
                "textChanged":true
            }, [_arg_3[22]], null);
            _arg_4[74] = new PropertyWatcher("loadCapacity", {"propertyChange":true}, [_arg_3[22]], _arg_2);
            _arg_4[70].updateParent(_arg_1);
            _arg_4[113].updateParent(_arg_1);
            _arg_4[111].updateParent(_arg_1);
            _arg_4[67].updateParent(_arg_1);
            _arg_4[69].updateParent(_arg_1);
            _arg_4[7].updateParent(_arg_1);
            _arg_4[7].addChild(_arg_4[8]);
            _arg_4[8].addChild(_arg_4[9]);
            _arg_4[3].updateParent(_arg_1);
            _arg_4[114].updateParent(_arg_1);
            _arg_4[25].updateParent(_arg_1);
            _arg_4[25].addChild(_arg_4[26]);
            _arg_4[26].addChild(_arg_4[27]);
            _arg_4[68].updateParent(_arg_1);
            _arg_4[13].updateParent(_arg_1);
            _arg_4[13].addChild(_arg_4[14]);
            _arg_4[14].addChild(_arg_4[15]);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[34].updateParent(_arg_1);
            _arg_4[34].addChild(_arg_4[35]);
            _arg_4[35].addChild(_arg_4[36]);
            _arg_4[10].updateParent(_arg_1);
            _arg_4[10].addChild(_arg_4[11]);
            _arg_4[11].addChild(_arg_4[12]);
            _arg_4[28].updateParent(_arg_1);
            _arg_4[28].addChild(_arg_4[29]);
            _arg_4[29].addChild(_arg_4[30]);
            _arg_4[108].updateParent(_arg_1);
            _arg_4[108].addChild(_arg_4[109]);
            _arg_4[31].updateParent(_arg_1);
            _arg_4[31].addChild(_arg_4[32]);
            _arg_4[32].addChild(_arg_4[33]);
            _arg_4[19].updateParent(_arg_1);
            _arg_4[19].addChild(_arg_4[20]);
            _arg_4[20].addChild(_arg_4[21]);
            _arg_4[22].updateParent(_arg_1);
            _arg_4[22].addChild(_arg_4[23]);
            _arg_4[23].addChild(_arg_4[24]);
            _arg_4[71].updateParent(_arg_1);
            _arg_4[71].addChild(_arg_4[72]);
            _arg_4[43].updateParent(_arg_1);
            _arg_4[43].addChild(_arg_4[66]);
            _arg_4[43].addChild(_arg_4[54]);
            _arg_4[43].addChild(_arg_4[44]);
            _arg_4[43].addChild(_arg_4[62]);
            _arg_4[43].addChild(_arg_4[60]);
            _arg_4[43].addChild(_arg_4[48]);
            _arg_4[43].addChild(_arg_4[58]);
            _arg_4[43].addChild(_arg_4[46]);
            _arg_4[43].addChild(_arg_4[56]);
            _arg_4[43].addChild(_arg_4[52]);
            _arg_4[43].addChild(_arg_4[50]);
            _arg_4[43].addChild(_arg_4[64]);
            _arg_4[41].updateParent(_arg_1);
            _arg_4[81].updateParent(_arg_1);
            _arg_4[81].addChild(_arg_4[82]);
            _arg_4[82].addChild(_arg_4[83]);
            _arg_4[106].updateParent(_arg_1);
            _arg_4[106].addChild(_arg_4[107]);
            _arg_4[84].updateParent(_arg_1);
            _arg_4[84].addChild(_arg_4[85]);
            _arg_4[85].addChild(_arg_4[86]);
            _arg_4[75].updateParent(_arg_1);
            _arg_4[75].addChild(_arg_4[76]);
            _arg_4[76].addChild(_arg_4[77]);
            _arg_4[92].updateParent(_arg_1);
            _arg_4[92].addChild(_arg_4[95]);
            _arg_4[92].addChild(_arg_4[93]);
            _arg_4[92].addChild(_arg_4[97]);
            _arg_4[92].addChild(_arg_4[101]);
            _arg_4[92].addChild(_arg_4[99]);
            _arg_4[87].updateParent(_arg_1);
            _arg_4[87].addChild(_arg_4[88]);
            _arg_4[88].addChild(_arg_4[89]);
            _arg_4[37].updateParent(_arg_1);
            _arg_4[37].addChild(_arg_4[38]);
            _arg_4[38].addChild(_arg_4[39]);
            _arg_4[4].updateParent(_arg_1);
            _arg_4[4].addChild(_arg_4[5]);
            _arg_4[5].addChild(_arg_4[6]);
            _arg_4[16].updateParent(_arg_1);
            _arg_4[16].addChild(_arg_4[17]);
            _arg_4[17].addChild(_arg_4[18]);
            _arg_4[102].updateParent(_arg_1);
            _arg_4[78].updateParent(_arg_1);
            _arg_4[78].addChild(_arg_4[79]);
            _arg_4[79].addChild(_arg_4[80]);
            _arg_4[74].updateParent(_arg_1);
        }


    }
}//package 

