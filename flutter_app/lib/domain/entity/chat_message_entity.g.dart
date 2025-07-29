// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageEntityAdapter extends TypeAdapter<ChatMessageEntity> {
  @override
  final int typeId = 0;

  @override
  ChatMessageEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageEntity(
      message: fields[0] as String,
      timestamp: fields[1] as DateTime,
      originType: fields[2] as MessageOriginType,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.originType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MessageOriginTypeAdapter extends TypeAdapter<MessageOriginType> {
  @override
  final int typeId = 1;

  @override
  MessageOriginType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageOriginType.incoming;
      case 1:
        return MessageOriginType.outgoing;
      default:
        return MessageOriginType.incoming;
    }
  }

  @override
  void write(BinaryWriter writer, MessageOriginType obj) {
    switch (obj) {
      case MessageOriginType.incoming:
        writer.writeByte(0);
        break;
      case MessageOriginType.outgoing:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageOriginTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
