// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//_view_module_herosMansion_HeroPropertiesWatcherSetupUtil

package 
{
    import flash.display.Sprite;
    import mx.binding.IWatcherSetupUtil;
    import view.module.herosMansion.HeroProperties;
    import mx.core.IFlexModuleFactory;
    import mx.binding.PropertyWatcher;

    public class _view_module_herosMansion_HeroPropertiesWatcherSetupUtil extends Sprite implements IWatcherSetupUtil 
    {


        public static function init(_arg_1:IFlexModuleFactory):void
        {
            HeroProperties.watcherSetupUtil = new (_view_module_herosMansion_HeroPropertiesWatcherSetupUtil)();
        }


        public function setup(_arg_1:Object, _arg_2:Function, _arg_3:Array, _arg_4:Array):void
        {
            _arg_4[1] = new PropertyWatcher("heroList", {"propertyChange":true}, [_arg_3[1]], _arg_2);
            _arg_4[63] = new PropertyWatcher("heroEquipEnable", {"propertyChange":true}, [_arg_3[59]], _arg_2);
            _arg_4[5] = new PropertyWatcher("heroMes", {"propertyChange":true}, [_arg_3[15], _arg_3[51], _arg_3[23], _arg_3[43], _arg_3[16], _arg_3[31], _arg_3[35], _arg_3[7], _arg_3[54], _arg_3[49], _arg_3[41], _arg_3[53], _arg_3[9], _arg_3[21], _arg_3[33], _arg_3[60], _arg_3[29], _arg_3[52], _arg_3[24], _arg_3[47], _arg_3[19], _arg_3[58], _arg_3[11], _arg_3[18], _arg_3[39], _arg_3[27], _arg_3[45], _arg_3[13], _arg_3[25], _arg_3[37], _arg_3[56], _arg_3[5]], _arg_2);
            _arg_4[10] = new PropertyWatcher("level", {"propertyChange":true}, [_arg_3[51], _arg_3[9]], null);
            _arg_4[29] = new PropertyWatcher("leadership", {"propertyChange":true}, [_arg_3[37]], null);
            _arg_4[31] = new PropertyWatcher("speed", {"propertyChange":true}, [_arg_3[39]], null);
            _arg_4[42] = new PropertyWatcher("power", {"propertyChange":true}, [_arg_3[43]], null);
            _arg_4[43] = new PropertyWatcher("attack", {"propertyChange":true}, [_arg_3[43]], null);
            _arg_4[35] = new PropertyWatcher("management", {"propertyChange":true}, [_arg_3[41]], null);
            _arg_4[57] = new PropertyWatcher("stamina", {"propertyChange":true}, [_arg_3[49]], null);
            _arg_4[15] = new PropertyWatcher("status", {"propertyChange":true}, [_arg_3[15], _arg_3[13], _arg_3[19], _arg_3[58], _arg_3[23], _arg_3[21], _arg_3[31], _arg_3[25], _arg_3[56], _arg_3[27]], null);
            _arg_4[58] = new PropertyWatcher("maxStrength", {"propertyChange":true}, [_arg_3[49]], null);
            _arg_4[40] = new PropertyWatcher("powerBuffAdded", {"propertyChange":true}, [_arg_3[43]], null);
            _arg_4[49] = new PropertyWatcher("stratagem", {"propertyChange":true}, [_arg_3[45]], null);
            _arg_4[12] = new PropertyWatcher("experience", {"propertyChange":true}, [_arg_3[11], _arg_3[29]], null);
            _arg_4[64] = new PropertyWatcher("sex", {"propertyChange":true}, [_arg_3[60]], null);
            _arg_4[18] = new PropertyWatcher("isHero", {"propertyChange":true}, [_arg_3[51], _arg_3[33], _arg_3[21], _arg_3[16], _arg_3[18], _arg_3[35], _arg_3[24]], null);
            _arg_4[13] = new PropertyWatcher("upgradeExp", {"propertyChange":true}, [_arg_3[11], _arg_3[29]], null);
            _arg_4[27] = new PropertyWatcher("loyalty", {"propertyChange":true}, [_arg_3[35]], null);
            _arg_4[33] = new PropertyWatcher("managementBuffAdded", {"propertyChange":true}, [_arg_3[41]], null);
            _arg_4[54] = new PropertyWatcher("remainPoint", {"propertyChange":true}, [_arg_3[47], _arg_3[53], _arg_3[52], _arg_3[54]], null);
            _arg_4[6] = new PropertyWatcher("logoUrl", {"propertyChange":true}, [_arg_3[5]], null);
            _arg_4[50] = new PropertyWatcher("intelligence", {"propertyChange":true}, [_arg_3[45]], null);
            _arg_4[47] = new PropertyWatcher("stratagemBuffAdded", {"propertyChange":true}, [_arg_3[45]], null);
            _arg_4[8] = new PropertyWatcher("name", {"propertyChange":true}, [_arg_3[7]], null);
            _arg_4[36] = new PropertyWatcher("politics", {"propertyChange":true}, [_arg_3[41]], null);
            _arg_4[55] = new PropertyWatcher("addPointCounts", {"propertyChange":true}, [_arg_3[47], _arg_3[53], _arg_3[52], _arg_3[54]], _arg_2);
            _arg_4[1].updateParent(_arg_1);
            _arg_4[63].updateParent(_arg_1);
            _arg_4[5].updateParent(_arg_1);
            _arg_4[5].addChild(_arg_4[10]);
            _arg_4[5].addChild(_arg_4[29]);
            _arg_4[5].addChild(_arg_4[31]);
            _arg_4[5].addChild(_arg_4[42]);
            _arg_4[5].addChild(_arg_4[43]);
            _arg_4[5].addChild(_arg_4[35]);
            _arg_4[5].addChild(_arg_4[57]);
            _arg_4[5].addChild(_arg_4[15]);
            _arg_4[5].addChild(_arg_4[58]);
            _arg_4[5].addChild(_arg_4[40]);
            _arg_4[5].addChild(_arg_4[49]);
            _arg_4[5].addChild(_arg_4[12]);
            _arg_4[5].addChild(_arg_4[64]);
            _arg_4[5].addChild(_arg_4[18]);
            _arg_4[5].addChild(_arg_4[13]);
            _arg_4[5].addChild(_arg_4[27]);
            _arg_4[5].addChild(_arg_4[33]);
            _arg_4[5].addChild(_arg_4[54]);
            _arg_4[5].addChild(_arg_4[6]);
            _arg_4[5].addChild(_arg_4[50]);
            _arg_4[5].addChild(_arg_4[47]);
            _arg_4[5].addChild(_arg_4[8]);
            _arg_4[5].addChild(_arg_4[36]);
            _arg_4[55].updateParent(_arg_1);
        }


    }
}//package 

