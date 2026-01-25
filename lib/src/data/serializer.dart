library serializer;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:hello_universe/src/data/apod.dart';
import 'package:hello_universe/src/data/media_type.dart';

part 'serializer.g.dart';

@SerializersFor([Apod, MediaType])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
