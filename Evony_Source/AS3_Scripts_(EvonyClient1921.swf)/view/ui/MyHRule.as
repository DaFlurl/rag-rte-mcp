// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.MyHRule

package view.ui
{
    import mx.controls.HRule;
    import flash.display.Graphics;
    import flash.geom.Matrix;
    import flash.display.GradientType;

    public class MyHRule extends HRule 
    {


        override public function initialize():void
        {
            super.initialize();
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Graphics = graphics;
            _local_3.clear();
            var _local_4:Number = 10;
            if (_local_4 > _arg_2)
            {
                _local_4 = _arg_2;
            };
            var _local_5:Number = 0;
            var _local_6:Number = ((_arg_2 - _local_4) / 2);
            var _local_7:Number = _arg_1;
            var _local_8:Number = (_local_6 + _local_4);
            var _local_9:Matrix = new Matrix();
            _local_9.createGradientBox(_arg_1, 2, 0, 0, 0);
            this.graphics.lineStyle(1, 0);
            this.graphics.lineGradientStyle(GradientType.LINEAR, [740218, 740218, 740218], [0, 1, 0], [0, 128, 0xFF], _local_9);
            _local_3.moveTo(_local_5, _local_6);
            _local_3.lineTo(_local_7, _local_6);
        }


    }
}//package view.ui

