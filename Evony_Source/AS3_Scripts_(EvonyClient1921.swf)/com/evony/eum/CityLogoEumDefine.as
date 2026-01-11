// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.eum.CityLogoEumDefine

package com.evony.eum
{
    import mx.collections.ArrayCollection;

    public class CityLogoEumDefine 
    {

        private static var instance:CityLogoEumDefine = new (CityLogoEumDefine)();

        private var cityLogo:ArrayCollection = new ArrayCollection();

        public function CityLogoEumDefine()
        {
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_01.png");
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_02.png");
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_03.png");
            this.cityLogo.addItem("images/icon/cityLogo/citylogo_04.png");
        }

        public static function getCityLogoArray():ArrayCollection
        {
            return (instance.cityLogo);
        }


    }
}//package com.evony.eum

