// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.rt.XMLAccessor

package r1.deval.rt
{
    import r1.deval.rt.Accessor;
    import r1.deval.rt.IExpr;
    import r1.deval.rt.RTError;
    import r1.deval.rt.Env;
    import r1.deval.rt.*;

    internal class XMLAccessor extends Accessor 
    {

        internal var ns:IExpr;
        internal var flags:int;
        internal var dotQuery:Boolean;

        public function XMLAccessor(_arg_1:IExpr, _arg_2:*, _arg_3:IExpr, _arg_4:Boolean=false, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_2);
            this.dotQuery = _arg_4;
            this.ns = _arg_3;
            this.flags = 0;
            if (_arg_5)
            {
                flags = (flags | 0x02);
            };
            if (_arg_6)
            {
                flags = (flags | 0x01);
            };
        }

        override public function setValue(_arg_1:Object):void
        {
            var _local_2:Object = getIndex();
            if (ns != null)
            {
                _local_2 = new QName(ns.getAny(), _local_2);
            };
            var _local_3:Object = host.getAny();
            switch (flags)
            {
                case 0:
                    _local_3[_local_2] = _arg_1;
                    return;
                case 2:
                    _local_3.@[_local_2] = _arg_1;
                    return;
                default:
                    throw (new RTError("msg.unknown.xml.operator"));
            };
        }

        override public function getAny():Object
        {
            var _local_1:Object;
            if (dotQuery)
            {
                return (doDotQuery());
            };
            var _local_2:Object = getIndex();
            if (ns != null)
            {
                _local_2 = new QName(ns.getAny(), _local_2);
            };
            if (host == null)
            {
                _local_1 = Env.peekObject();
                switch (flags)
                {
                    case 0:
                        return (_local_1[_local_2]);
                    case 1:
                        return (_local_1.descendants(_local_2));
                    case 2:
                        return (_local_1.@[_local_2]);
                    case 3:
                        return (_local_1..@[_local_2]);
                };
            }
            else
            {
                _local_1 = host.getAny();
                switch (flags)
                {
                    case 0:
                        return (_local_1[_local_2]);
                    case 1:
                        return (_local_1.descendants(_local_2));
                    case 2:
                        return (_local_1.@[_local_2]);
                    case 3:
                        return (_local_1..@[_local_2]);
                };
            };
            throw (new RTError("msg.unknown.xml.operator"));
        }

        private function doDotQuery():Object
        {
            var _local_2:XML;
            var _local_3:*;
            var _local_1:Object = host.getAny();
            if ((_local_1 is XML))
            {
                Env.pushObject(_local_1);
                if (!getIndexAsBoolean())
                {
                    return (new (XMLList)(""));
                };
                Env.popObject();
            }
            else
            {
                _local_2 = <root/>
                ;
                for each (_local_3 in (_local_1 as XMLList))
                {
                    Env.pushObject(_local_3);
                    if (getIndexAsBoolean())
                    {
                        _local_2.appendChild(_local_3);
                    };
                    Env.popObject();
                };
                _local_1 = _local_2.children();
            };
            return (_local_1);
        }


    }
}//package r1.deval.rt

