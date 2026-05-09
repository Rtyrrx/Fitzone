// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
mixin _$FitnessCenterDaoMixin on DatabaseAccessor<AppDatabase> {
  $DbFitnessCentersTable get dbFitnessCenters =>
      attachedDatabase.dbFitnessCenters;
  FitnessCenterDaoManager get managers => FitnessCenterDaoManager(this);
}

class FitnessCenterDaoManager {
  final _$FitnessCenterDaoMixin _db;
  FitnessCenterDaoManager(this._db);
  $$DbFitnessCentersTableTableManager get dbFitnessCenters =>
      $$DbFitnessCentersTableTableManager(
        _db.attachedDatabase,
        _db.dbFitnessCenters,
      );
}

mixin _$MembershipDaoMixin on DatabaseAccessor<AppDatabase> {
  $DbMembershipsTable get dbMemberships => attachedDatabase.dbMemberships;
  MembershipDaoManager get managers => MembershipDaoManager(this);
}

class MembershipDaoManager {
  final _$MembershipDaoMixin _db;
  MembershipDaoManager(this._db);
  $$DbMembershipsTableTableManager get dbMemberships =>
      $$DbMembershipsTableTableManager(_db.attachedDatabase, _db.dbMemberships);
}

mixin _$BookingDaoMixin on DatabaseAccessor<AppDatabase> {
  $DbBookingsTable get dbBookings => attachedDatabase.dbBookings;
  BookingDaoManager get managers => BookingDaoManager(this);
}

class BookingDaoManager {
  final _$BookingDaoMixin _db;
  BookingDaoManager(this._db);
  $$DbBookingsTableTableManager get dbBookings =>
      $$DbBookingsTableTableManager(_db.attachedDatabase, _db.dbBookings);
}

mixin _$BookingItemDaoMixin on DatabaseAccessor<AppDatabase> {
  $DbBookingItemsTable get dbBookingItems => attachedDatabase.dbBookingItems;
  BookingItemDaoManager get managers => BookingItemDaoManager(this);
}

class BookingItemDaoManager {
  final _$BookingItemDaoMixin _db;
  BookingItemDaoManager(this._db);
  $$DbBookingItemsTableTableManager get dbBookingItems =>
      $$DbBookingItemsTableTableManager(
        _db.attachedDatabase,
        _db.dbBookingItems,
      );
}

class $DbFitnessCentersTable extends DbFitnessCenters
    with TableInfo<$DbFitnessCentersTable, DbFitnessCenter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbFitnessCentersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sportTypeMeta = const VerificationMeta(
    'sportType',
  );
  @override
  late final GeneratedColumn<String> sportType = GeneratedColumn<String>(
    'sport_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingHoursMeta = const VerificationMeta(
    'openingHours',
  );
  @override
  late final GeneratedColumn<String> openingHours = GeneratedColumn<String>(
    'opening_hours',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _membershipPriceMeta = const VerificationMeta(
    'membershipPrice',
  );
  @override
  late final GeneratedColumn<String> membershipPrice = GeneratedColumn<String>(
    'membership_price',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOpenMeta = const VerificationMeta('isOpen');
  @override
  late final GeneratedColumn<bool> isOpen = GeneratedColumn<bool>(
    'is_open',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_open" IN (0, 1))',
    ),
  );
  static const VerificationMeta _distanceMeta = const VerificationMeta(
    'distance',
  );
  @override
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
    'distance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    location,
    description,
    imageUrl,
    sportType,
    rating,
    openingHours,
    membershipPrice,
    isOpen,
    distance,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fitness_centers';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbFitnessCenter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('sport_type')) {
      context.handle(
        _sportTypeMeta,
        sportType.isAcceptableOrUnknown(data['sport_type']!, _sportTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sportTypeMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('opening_hours')) {
      context.handle(
        _openingHoursMeta,
        openingHours.isAcceptableOrUnknown(
          data['opening_hours']!,
          _openingHoursMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingHoursMeta);
    }
    if (data.containsKey('membership_price')) {
      context.handle(
        _membershipPriceMeta,
        membershipPrice.isAcceptableOrUnknown(
          data['membership_price']!,
          _membershipPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_membershipPriceMeta);
    }
    if (data.containsKey('is_open')) {
      context.handle(
        _isOpenMeta,
        isOpen.isAcceptableOrUnknown(data['is_open']!, _isOpenMeta),
      );
    } else if (isInserting) {
      context.missing(_isOpenMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(
        _distanceMeta,
        distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbFitnessCenter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbFitnessCenter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      sportType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sport_type'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
      openingHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opening_hours'],
      )!,
      membershipPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}membership_price'],
      )!,
      isOpen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_open'],
      )!,
      distance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance'],
      )!,
    );
  }

  @override
  $DbFitnessCentersTable createAlias(String alias) {
    return $DbFitnessCentersTable(attachedDatabase, alias);
  }
}

class DbFitnessCenter extends DataClass implements Insertable<DbFitnessCenter> {
  final int id;
  final String name;
  final String location;
  final String description;
  final String imageUrl;
  final String sportType;
  final double rating;
  final String openingHours;
  final String membershipPrice;
  final bool isOpen;
  final double distance;
  const DbFitnessCenter({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.sportType,
    required this.rating,
    required this.openingHours,
    required this.membershipPrice,
    required this.isOpen,
    required this.distance,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['location'] = Variable<String>(location);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    map['sport_type'] = Variable<String>(sportType);
    map['rating'] = Variable<double>(rating);
    map['opening_hours'] = Variable<String>(openingHours);
    map['membership_price'] = Variable<String>(membershipPrice);
    map['is_open'] = Variable<bool>(isOpen);
    map['distance'] = Variable<double>(distance);
    return map;
  }

  DbFitnessCentersCompanion toCompanion(bool nullToAbsent) {
    return DbFitnessCentersCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      description: Value(description),
      imageUrl: Value(imageUrl),
      sportType: Value(sportType),
      rating: Value(rating),
      openingHours: Value(openingHours),
      membershipPrice: Value(membershipPrice),
      isOpen: Value(isOpen),
      distance: Value(distance),
    );
  }

  factory DbFitnessCenter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbFitnessCenter(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String>(json['location']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      sportType: serializer.fromJson<String>(json['sportType']),
      rating: serializer.fromJson<double>(json['rating']),
      openingHours: serializer.fromJson<String>(json['openingHours']),
      membershipPrice: serializer.fromJson<String>(json['membershipPrice']),
      isOpen: serializer.fromJson<bool>(json['isOpen']),
      distance: serializer.fromJson<double>(json['distance']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String>(location),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'sportType': serializer.toJson<String>(sportType),
      'rating': serializer.toJson<double>(rating),
      'openingHours': serializer.toJson<String>(openingHours),
      'membershipPrice': serializer.toJson<String>(membershipPrice),
      'isOpen': serializer.toJson<bool>(isOpen),
      'distance': serializer.toJson<double>(distance),
    };
  }

  DbFitnessCenter copyWith({
    int? id,
    String? name,
    String? location,
    String? description,
    String? imageUrl,
    String? sportType,
    double? rating,
    String? openingHours,
    String? membershipPrice,
    bool? isOpen,
    double? distance,
  }) => DbFitnessCenter(
    id: id ?? this.id,
    name: name ?? this.name,
    location: location ?? this.location,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    sportType: sportType ?? this.sportType,
    rating: rating ?? this.rating,
    openingHours: openingHours ?? this.openingHours,
    membershipPrice: membershipPrice ?? this.membershipPrice,
    isOpen: isOpen ?? this.isOpen,
    distance: distance ?? this.distance,
  );
  DbFitnessCenter copyWithCompanion(DbFitnessCentersCompanion data) {
    return DbFitnessCenter(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      sportType: data.sportType.present ? data.sportType.value : this.sportType,
      rating: data.rating.present ? data.rating.value : this.rating,
      openingHours: data.openingHours.present
          ? data.openingHours.value
          : this.openingHours,
      membershipPrice: data.membershipPrice.present
          ? data.membershipPrice.value
          : this.membershipPrice,
      isOpen: data.isOpen.present ? data.isOpen.value : this.isOpen,
      distance: data.distance.present ? data.distance.value : this.distance,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbFitnessCenter(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sportType: $sportType, ')
          ..write('rating: $rating, ')
          ..write('openingHours: $openingHours, ')
          ..write('membershipPrice: $membershipPrice, ')
          ..write('isOpen: $isOpen, ')
          ..write('distance: $distance')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    location,
    description,
    imageUrl,
    sportType,
    rating,
    openingHours,
    membershipPrice,
    isOpen,
    distance,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbFitnessCenter &&
          other.id == this.id &&
          other.name == this.name &&
          other.location == this.location &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.sportType == this.sportType &&
          other.rating == this.rating &&
          other.openingHours == this.openingHours &&
          other.membershipPrice == this.membershipPrice &&
          other.isOpen == this.isOpen &&
          other.distance == this.distance);
}

class DbFitnessCentersCompanion extends UpdateCompanion<DbFitnessCenter> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> location;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<String> sportType;
  final Value<double> rating;
  final Value<String> openingHours;
  final Value<String> membershipPrice;
  final Value<bool> isOpen;
  final Value<double> distance;
  const DbFitnessCentersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.sportType = const Value.absent(),
    this.rating = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.membershipPrice = const Value.absent(),
    this.isOpen = const Value.absent(),
    this.distance = const Value.absent(),
  });
  DbFitnessCentersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String location,
    required String description,
    this.imageUrl = const Value.absent(),
    required String sportType,
    required double rating,
    required String openingHours,
    required String membershipPrice,
    required bool isOpen,
    required double distance,
  }) : name = Value(name),
       location = Value(location),
       description = Value(description),
       sportType = Value(sportType),
       rating = Value(rating),
       openingHours = Value(openingHours),
       membershipPrice = Value(membershipPrice),
       isOpen = Value(isOpen),
       distance = Value(distance);
  static Insertable<DbFitnessCenter> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? location,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? sportType,
    Expression<double>? rating,
    Expression<String>? openingHours,
    Expression<String>? membershipPrice,
    Expression<bool>? isOpen,
    Expression<double>? distance,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (sportType != null) 'sport_type': sportType,
      if (rating != null) 'rating': rating,
      if (openingHours != null) 'opening_hours': openingHours,
      if (membershipPrice != null) 'membership_price': membershipPrice,
      if (isOpen != null) 'is_open': isOpen,
      if (distance != null) 'distance': distance,
    });
  }

  DbFitnessCentersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? location,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<String>? sportType,
    Value<double>? rating,
    Value<String>? openingHours,
    Value<String>? membershipPrice,
    Value<bool>? isOpen,
    Value<double>? distance,
  }) {
    return DbFitnessCentersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      sportType: sportType ?? this.sportType,
      rating: rating ?? this.rating,
      openingHours: openingHours ?? this.openingHours,
      membershipPrice: membershipPrice ?? this.membershipPrice,
      isOpen: isOpen ?? this.isOpen,
      distance: distance ?? this.distance,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (sportType.present) {
      map['sport_type'] = Variable<String>(sportType.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (openingHours.present) {
      map['opening_hours'] = Variable<String>(openingHours.value);
    }
    if (membershipPrice.present) {
      map['membership_price'] = Variable<String>(membershipPrice.value);
    }
    if (isOpen.present) {
      map['is_open'] = Variable<bool>(isOpen.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbFitnessCentersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('sportType: $sportType, ')
          ..write('rating: $rating, ')
          ..write('openingHours: $openingHours, ')
          ..write('membershipPrice: $membershipPrice, ')
          ..write('isOpen: $isOpen, ')
          ..write('distance: $distance')
          ..write(')'))
        .toString();
  }
}

class $DbMembershipsTable extends DbMemberships
    with TableInfo<$DbMembershipsTable, DbMembership> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbMembershipsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _centerIdMeta = const VerificationMeta(
    'centerId',
  );
  @override
  late final GeneratedColumn<int> centerId = GeneratedColumn<int>(
    'center_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    centerId,
    name,
    price,
    description,
    duration,
    imageUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memberships';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbMembership> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('center_id')) {
      context.handle(
        _centerIdMeta,
        centerId.isAcceptableOrUnknown(data['center_id']!, _centerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_centerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbMembership map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbMembership(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      centerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}center_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $DbMembershipsTable createAlias(String alias) {
    return $DbMembershipsTable(attachedDatabase, alias);
  }
}

class DbMembership extends DataClass implements Insertable<DbMembership> {
  final int id;
  final int centerId;
  final String name;
  final double price;
  final String description;
  final String duration;
  final String imageUrl;
  const DbMembership({
    required this.id,
    required this.centerId,
    required this.name,
    required this.price,
    required this.description,
    required this.duration,
    required this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['center_id'] = Variable<int>(centerId);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['description'] = Variable<String>(description);
    map['duration'] = Variable<String>(duration);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  DbMembershipsCompanion toCompanion(bool nullToAbsent) {
    return DbMembershipsCompanion(
      id: Value(id),
      centerId: Value(centerId),
      name: Value(name),
      price: Value(price),
      description: Value(description),
      duration: Value(duration),
      imageUrl: Value(imageUrl),
    );
  }

  factory DbMembership.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbMembership(
      id: serializer.fromJson<int>(json['id']),
      centerId: serializer.fromJson<int>(json['centerId']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      description: serializer.fromJson<String>(json['description']),
      duration: serializer.fromJson<String>(json['duration']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'centerId': serializer.toJson<int>(centerId),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'description': serializer.toJson<String>(description),
      'duration': serializer.toJson<String>(duration),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  DbMembership copyWith({
    int? id,
    int? centerId,
    String? name,
    double? price,
    String? description,
    String? duration,
    String? imageUrl,
  }) => DbMembership(
    id: id ?? this.id,
    centerId: centerId ?? this.centerId,
    name: name ?? this.name,
    price: price ?? this.price,
    description: description ?? this.description,
    duration: duration ?? this.duration,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  DbMembership copyWithCompanion(DbMembershipsCompanion data) {
    return DbMembership(
      id: data.id.present ? data.id.value : this.id,
      centerId: data.centerId.present ? data.centerId.value : this.centerId,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      description: data.description.present
          ? data.description.value
          : this.description,
      duration: data.duration.present ? data.duration.value : this.duration,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbMembership(')
          ..write('id: $id, ')
          ..write('centerId: $centerId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('duration: $duration, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, centerId, name, price, description, duration, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbMembership &&
          other.id == this.id &&
          other.centerId == this.centerId &&
          other.name == this.name &&
          other.price == this.price &&
          other.description == this.description &&
          other.duration == this.duration &&
          other.imageUrl == this.imageUrl);
}

class DbMembershipsCompanion extends UpdateCompanion<DbMembership> {
  final Value<int> id;
  final Value<int> centerId;
  final Value<String> name;
  final Value<double> price;
  final Value<String> description;
  final Value<String> duration;
  final Value<String> imageUrl;
  const DbMembershipsCompanion({
    this.id = const Value.absent(),
    this.centerId = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.description = const Value.absent(),
    this.duration = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  DbMembershipsCompanion.insert({
    this.id = const Value.absent(),
    required int centerId,
    required String name,
    required double price,
    required String description,
    required String duration,
    this.imageUrl = const Value.absent(),
  }) : centerId = Value(centerId),
       name = Value(name),
       price = Value(price),
       description = Value(description),
       duration = Value(duration);
  static Insertable<DbMembership> custom({
    Expression<int>? id,
    Expression<int>? centerId,
    Expression<String>? name,
    Expression<double>? price,
    Expression<String>? description,
    Expression<String>? duration,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (centerId != null) 'center_id': centerId,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (description != null) 'description': description,
      if (duration != null) 'duration': duration,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  DbMembershipsCompanion copyWith({
    Value<int>? id,
    Value<int>? centerId,
    Value<String>? name,
    Value<double>? price,
    Value<String>? description,
    Value<String>? duration,
    Value<String>? imageUrl,
  }) {
    return DbMembershipsCompanion(
      id: id ?? this.id,
      centerId: centerId ?? this.centerId,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (centerId.present) {
      map['center_id'] = Variable<int>(centerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbMembershipsCompanion(')
          ..write('id: $id, ')
          ..write('centerId: $centerId, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('duration: $duration, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

class $DbBookingsTable extends DbBookings
    with TableInfo<$DbBookingsTable, DbBooking> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBookingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNameMeta = const VerificationMeta(
    'contactName',
  );
  @override
  late final GeneratedColumn<String> contactName = GeneratedColumn<String>(
    'contact_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedDateMeta = const VerificationMeta(
    'selectedDate',
  );
  @override
  late final GeneratedColumn<DateTime> selectedDate = GeneratedColumn<DateTime>(
    'selected_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _selectedTimeMeta = const VerificationMeta(
    'selectedTime',
  );
  @override
  late final GeneratedColumn<String> selectedTime = GeneratedColumn<String>(
    'selected_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    contactName,
    selectedDate,
    selectedTime,
    status,
    totalCost,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbBooking> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('contact_name')) {
      context.handle(
        _contactNameMeta,
        contactName.isAcceptableOrUnknown(
          data['contact_name']!,
          _contactNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactNameMeta);
    }
    if (data.containsKey('selected_date')) {
      context.handle(
        _selectedDateMeta,
        selectedDate.isAcceptableOrUnknown(
          data['selected_date']!,
          _selectedDateMeta,
        ),
      );
    }
    if (data.containsKey('selected_time')) {
      context.handle(
        _selectedTimeMeta,
        selectedTime.isAcceptableOrUnknown(
          data['selected_time']!,
          _selectedTimeMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbBooking map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBooking(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      contactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_name'],
      )!,
      selectedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}selected_date'],
      ),
      selectedTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_time'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DbBookingsTable createAlias(String alias) {
    return $DbBookingsTable(attachedDatabase, alias);
  }
}

class DbBooking extends DataClass implements Insertable<DbBooking> {
  final int id;
  final String userId;
  final String contactName;
  final DateTime? selectedDate;
  final String? selectedTime;
  final String status;
  final double totalCost;
  final DateTime createdAt;
  const DbBooking({
    required this.id,
    required this.userId,
    required this.contactName,
    this.selectedDate,
    this.selectedTime,
    required this.status,
    required this.totalCost,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['contact_name'] = Variable<String>(contactName);
    if (!nullToAbsent || selectedDate != null) {
      map['selected_date'] = Variable<DateTime>(selectedDate);
    }
    if (!nullToAbsent || selectedTime != null) {
      map['selected_time'] = Variable<String>(selectedTime);
    }
    map['status'] = Variable<String>(status);
    map['total_cost'] = Variable<double>(totalCost);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbBookingsCompanion toCompanion(bool nullToAbsent) {
    return DbBookingsCompanion(
      id: Value(id),
      userId: Value(userId),
      contactName: Value(contactName),
      selectedDate: selectedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedDate),
      selectedTime: selectedTime == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedTime),
      status: Value(status),
      totalCost: Value(totalCost),
      createdAt: Value(createdAt),
    );
  }

  factory DbBooking.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBooking(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      contactName: serializer.fromJson<String>(json['contactName']),
      selectedDate: serializer.fromJson<DateTime?>(json['selectedDate']),
      selectedTime: serializer.fromJson<String?>(json['selectedTime']),
      status: serializer.fromJson<String>(json['status']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'contactName': serializer.toJson<String>(contactName),
      'selectedDate': serializer.toJson<DateTime?>(selectedDate),
      'selectedTime': serializer.toJson<String?>(selectedTime),
      'status': serializer.toJson<String>(status),
      'totalCost': serializer.toJson<double>(totalCost),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbBooking copyWith({
    int? id,
    String? userId,
    String? contactName,
    Value<DateTime?> selectedDate = const Value.absent(),
    Value<String?> selectedTime = const Value.absent(),
    String? status,
    double? totalCost,
    DateTime? createdAt,
  }) => DbBooking(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    contactName: contactName ?? this.contactName,
    selectedDate: selectedDate.present ? selectedDate.value : this.selectedDate,
    selectedTime: selectedTime.present ? selectedTime.value : this.selectedTime,
    status: status ?? this.status,
    totalCost: totalCost ?? this.totalCost,
    createdAt: createdAt ?? this.createdAt,
  );
  DbBooking copyWithCompanion(DbBookingsCompanion data) {
    return DbBooking(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      contactName: data.contactName.present
          ? data.contactName.value
          : this.contactName,
      selectedDate: data.selectedDate.present
          ? data.selectedDate.value
          : this.selectedDate,
      selectedTime: data.selectedTime.present
          ? data.selectedTime.value
          : this.selectedTime,
      status: data.status.present ? data.status.value : this.status,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbBooking(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('contactName: $contactName, ')
          ..write('selectedDate: $selectedDate, ')
          ..write('selectedTime: $selectedTime, ')
          ..write('status: $status, ')
          ..write('totalCost: $totalCost, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    contactName,
    selectedDate,
    selectedTime,
    status,
    totalCost,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBooking &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.contactName == this.contactName &&
          other.selectedDate == this.selectedDate &&
          other.selectedTime == this.selectedTime &&
          other.status == this.status &&
          other.totalCost == this.totalCost &&
          other.createdAt == this.createdAt);
}

class DbBookingsCompanion extends UpdateCompanion<DbBooking> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> contactName;
  final Value<DateTime?> selectedDate;
  final Value<String?> selectedTime;
  final Value<String> status;
  final Value<double> totalCost;
  final Value<DateTime> createdAt;
  const DbBookingsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.contactName = const Value.absent(),
    this.selectedDate = const Value.absent(),
    this.selectedTime = const Value.absent(),
    this.status = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbBookingsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String contactName,
    this.selectedDate = const Value.absent(),
    this.selectedTime = const Value.absent(),
    required String status,
    required double totalCost,
    required DateTime createdAt,
  }) : userId = Value(userId),
       contactName = Value(contactName),
       status = Value(status),
       totalCost = Value(totalCost),
       createdAt = Value(createdAt);
  static Insertable<DbBooking> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? contactName,
    Expression<DateTime>? selectedDate,
    Expression<String>? selectedTime,
    Expression<String>? status,
    Expression<double>? totalCost,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (contactName != null) 'contact_name': contactName,
      if (selectedDate != null) 'selected_date': selectedDate,
      if (selectedTime != null) 'selected_time': selectedTime,
      if (status != null) 'status': status,
      if (totalCost != null) 'total_cost': totalCost,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbBookingsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? contactName,
    Value<DateTime?>? selectedDate,
    Value<String?>? selectedTime,
    Value<String>? status,
    Value<double>? totalCost,
    Value<DateTime>? createdAt,
  }) {
    return DbBookingsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      contactName: contactName ?? this.contactName,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      status: status ?? this.status,
      totalCost: totalCost ?? this.totalCost,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (contactName.present) {
      map['contact_name'] = Variable<String>(contactName.value);
    }
    if (selectedDate.present) {
      map['selected_date'] = Variable<DateTime>(selectedDate.value);
    }
    if (selectedTime.present) {
      map['selected_time'] = Variable<String>(selectedTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBookingsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('contactName: $contactName, ')
          ..write('selectedDate: $selectedDate, ')
          ..write('selectedTime: $selectedTime, ')
          ..write('status: $status, ')
          ..write('totalCost: $totalCost, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DbBookingItemsTable extends DbBookingItems
    with TableInfo<$DbBookingItemsTable, DbBookingItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBookingItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookingIdMeta = const VerificationMeta(
    'bookingId',
  );
  @override
  late final GeneratedColumn<int> bookingId = GeneratedColumn<int>(
    'booking_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _membershipIdMeta = const VerificationMeta(
    'membershipId',
  );
  @override
  late final GeneratedColumn<int> membershipId = GeneratedColumn<int>(
    'membership_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookingId,
    membershipId,
    quantity,
    price,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'booking_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbBookingItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('booking_id')) {
      context.handle(
        _bookingIdMeta,
        bookingId.isAcceptableOrUnknown(data['booking_id']!, _bookingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookingIdMeta);
    }
    if (data.containsKey('membership_id')) {
      context.handle(
        _membershipIdMeta,
        membershipId.isAcceptableOrUnknown(
          data['membership_id']!,
          _membershipIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_membershipIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbBookingItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBookingItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}booking_id'],
      )!,
      membershipId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}membership_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
    );
  }

  @override
  $DbBookingItemsTable createAlias(String alias) {
    return $DbBookingItemsTable(attachedDatabase, alias);
  }
}

class DbBookingItem extends DataClass implements Insertable<DbBookingItem> {
  final int id;
  final int bookingId;
  final int membershipId;
  final int quantity;
  final double price;
  const DbBookingItem({
    required this.id,
    required this.bookingId,
    required this.membershipId,
    required this.quantity,
    required this.price,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['booking_id'] = Variable<int>(bookingId);
    map['membership_id'] = Variable<int>(membershipId);
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    return map;
  }

  DbBookingItemsCompanion toCompanion(bool nullToAbsent) {
    return DbBookingItemsCompanion(
      id: Value(id),
      bookingId: Value(bookingId),
      membershipId: Value(membershipId),
      quantity: Value(quantity),
      price: Value(price),
    );
  }

  factory DbBookingItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBookingItem(
      id: serializer.fromJson<int>(json['id']),
      bookingId: serializer.fromJson<int>(json['bookingId']),
      membershipId: serializer.fromJson<int>(json['membershipId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookingId': serializer.toJson<int>(bookingId),
      'membershipId': serializer.toJson<int>(membershipId),
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
    };
  }

  DbBookingItem copyWith({
    int? id,
    int? bookingId,
    int? membershipId,
    int? quantity,
    double? price,
  }) => DbBookingItem(
    id: id ?? this.id,
    bookingId: bookingId ?? this.bookingId,
    membershipId: membershipId ?? this.membershipId,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
  );
  DbBookingItem copyWithCompanion(DbBookingItemsCompanion data) {
    return DbBookingItem(
      id: data.id.present ? data.id.value : this.id,
      bookingId: data.bookingId.present ? data.bookingId.value : this.bookingId,
      membershipId: data.membershipId.present
          ? data.membershipId.value
          : this.membershipId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbBookingItem(')
          ..write('id: $id, ')
          ..write('bookingId: $bookingId, ')
          ..write('membershipId: $membershipId, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookingId, membershipId, quantity, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBookingItem &&
          other.id == this.id &&
          other.bookingId == this.bookingId &&
          other.membershipId == this.membershipId &&
          other.quantity == this.quantity &&
          other.price == this.price);
}

class DbBookingItemsCompanion extends UpdateCompanion<DbBookingItem> {
  final Value<int> id;
  final Value<int> bookingId;
  final Value<int> membershipId;
  final Value<int> quantity;
  final Value<double> price;
  const DbBookingItemsCompanion({
    this.id = const Value.absent(),
    this.bookingId = const Value.absent(),
    this.membershipId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
  });
  DbBookingItemsCompanion.insert({
    this.id = const Value.absent(),
    required int bookingId,
    required int membershipId,
    required int quantity,
    required double price,
  }) : bookingId = Value(bookingId),
       membershipId = Value(membershipId),
       quantity = Value(quantity),
       price = Value(price);
  static Insertable<DbBookingItem> custom({
    Expression<int>? id,
    Expression<int>? bookingId,
    Expression<int>? membershipId,
    Expression<int>? quantity,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookingId != null) 'booking_id': bookingId,
      if (membershipId != null) 'membership_id': membershipId,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
    });
  }

  DbBookingItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookingId,
    Value<int>? membershipId,
    Value<int>? quantity,
    Value<double>? price,
  }) {
    return DbBookingItemsCompanion(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      membershipId: membershipId ?? this.membershipId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookingId.present) {
      map['booking_id'] = Variable<int>(bookingId.value);
    }
    if (membershipId.present) {
      map['membership_id'] = Variable<int>(membershipId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBookingItemsCompanion(')
          ..write('id: $id, ')
          ..write('bookingId: $bookingId, ')
          ..write('membershipId: $membershipId, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DbFitnessCentersTable dbFitnessCenters = $DbFitnessCentersTable(
    this,
  );
  late final $DbMembershipsTable dbMemberships = $DbMembershipsTable(this);
  late final $DbBookingsTable dbBookings = $DbBookingsTable(this);
  late final $DbBookingItemsTable dbBookingItems = $DbBookingItemsTable(this);
  late final FitnessCenterDao fitnessCenterDao = FitnessCenterDao(
    this as AppDatabase,
  );
  late final MembershipDao membershipDao = MembershipDao(this as AppDatabase);
  late final BookingDao bookingDao = BookingDao(this as AppDatabase);
  late final BookingItemDao bookingItemDao = BookingItemDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dbFitnessCenters,
    dbMemberships,
    dbBookings,
    dbBookingItems,
  ];
}

typedef $$DbFitnessCentersTableCreateCompanionBuilder =
    DbFitnessCentersCompanion Function({
      Value<int> id,
      required String name,
      required String location,
      required String description,
      Value<String> imageUrl,
      required String sportType,
      required double rating,
      required String openingHours,
      required String membershipPrice,
      required bool isOpen,
      required double distance,
    });
typedef $$DbFitnessCentersTableUpdateCompanionBuilder =
    DbFitnessCentersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> location,
      Value<String> description,
      Value<String> imageUrl,
      Value<String> sportType,
      Value<double> rating,
      Value<String> openingHours,
      Value<String> membershipPrice,
      Value<bool> isOpen,
      Value<double> distance,
    });

class $$DbFitnessCentersTableFilterComposer
    extends Composer<_$AppDatabase, $DbFitnessCentersTable> {
  $$DbFitnessCentersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sportType => $composableBuilder(
    column: $table.sportType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get membershipPrice => $composableBuilder(
    column: $table.membershipPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbFitnessCentersTableOrderingComposer
    extends Composer<_$AppDatabase, $DbFitnessCentersTable> {
  $$DbFitnessCentersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sportType => $composableBuilder(
    column: $table.sportType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get membershipPrice => $composableBuilder(
    column: $table.membershipPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOpen => $composableBuilder(
    column: $table.isOpen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbFitnessCentersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbFitnessCentersTable> {
  $$DbFitnessCentersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get sportType =>
      $composableBuilder(column: $table.sportType, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get openingHours => $composableBuilder(
    column: $table.openingHours,
    builder: (column) => column,
  );

  GeneratedColumn<String> get membershipPrice => $composableBuilder(
    column: $table.membershipPrice,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isOpen =>
      $composableBuilder(column: $table.isOpen, builder: (column) => column);

  GeneratedColumn<double> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);
}

class $$DbFitnessCentersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbFitnessCentersTable,
          DbFitnessCenter,
          $$DbFitnessCentersTableFilterComposer,
          $$DbFitnessCentersTableOrderingComposer,
          $$DbFitnessCentersTableAnnotationComposer,
          $$DbFitnessCentersTableCreateCompanionBuilder,
          $$DbFitnessCentersTableUpdateCompanionBuilder,
          (
            DbFitnessCenter,
            BaseReferences<
              _$AppDatabase,
              $DbFitnessCentersTable,
              DbFitnessCenter
            >,
          ),
          DbFitnessCenter,
          PrefetchHooks Function()
        > {
  $$DbFitnessCentersTableTableManager(
    _$AppDatabase db,
    $DbFitnessCentersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbFitnessCentersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbFitnessCentersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbFitnessCentersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> sportType = const Value.absent(),
                Value<double> rating = const Value.absent(),
                Value<String> openingHours = const Value.absent(),
                Value<String> membershipPrice = const Value.absent(),
                Value<bool> isOpen = const Value.absent(),
                Value<double> distance = const Value.absent(),
              }) => DbFitnessCentersCompanion(
                id: id,
                name: name,
                location: location,
                description: description,
                imageUrl: imageUrl,
                sportType: sportType,
                rating: rating,
                openingHours: openingHours,
                membershipPrice: membershipPrice,
                isOpen: isOpen,
                distance: distance,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String location,
                required String description,
                Value<String> imageUrl = const Value.absent(),
                required String sportType,
                required double rating,
                required String openingHours,
                required String membershipPrice,
                required bool isOpen,
                required double distance,
              }) => DbFitnessCentersCompanion.insert(
                id: id,
                name: name,
                location: location,
                description: description,
                imageUrl: imageUrl,
                sportType: sportType,
                rating: rating,
                openingHours: openingHours,
                membershipPrice: membershipPrice,
                isOpen: isOpen,
                distance: distance,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbFitnessCentersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbFitnessCentersTable,
      DbFitnessCenter,
      $$DbFitnessCentersTableFilterComposer,
      $$DbFitnessCentersTableOrderingComposer,
      $$DbFitnessCentersTableAnnotationComposer,
      $$DbFitnessCentersTableCreateCompanionBuilder,
      $$DbFitnessCentersTableUpdateCompanionBuilder,
      (
        DbFitnessCenter,
        BaseReferences<_$AppDatabase, $DbFitnessCentersTable, DbFitnessCenter>,
      ),
      DbFitnessCenter,
      PrefetchHooks Function()
    >;
typedef $$DbMembershipsTableCreateCompanionBuilder =
    DbMembershipsCompanion Function({
      Value<int> id,
      required int centerId,
      required String name,
      required double price,
      required String description,
      required String duration,
      Value<String> imageUrl,
    });
typedef $$DbMembershipsTableUpdateCompanionBuilder =
    DbMembershipsCompanion Function({
      Value<int> id,
      Value<int> centerId,
      Value<String> name,
      Value<double> price,
      Value<String> description,
      Value<String> duration,
      Value<String> imageUrl,
    });

class $$DbMembershipsTableFilterComposer
    extends Composer<_$AppDatabase, $DbMembershipsTable> {
  $$DbMembershipsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get centerId => $composableBuilder(
    column: $table.centerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbMembershipsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbMembershipsTable> {
  $$DbMembershipsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get centerId => $composableBuilder(
    column: $table.centerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbMembershipsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbMembershipsTable> {
  $$DbMembershipsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get centerId =>
      $composableBuilder(column: $table.centerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$DbMembershipsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbMembershipsTable,
          DbMembership,
          $$DbMembershipsTableFilterComposer,
          $$DbMembershipsTableOrderingComposer,
          $$DbMembershipsTableAnnotationComposer,
          $$DbMembershipsTableCreateCompanionBuilder,
          $$DbMembershipsTableUpdateCompanionBuilder,
          (
            DbMembership,
            BaseReferences<_$AppDatabase, $DbMembershipsTable, DbMembership>,
          ),
          DbMembership,
          PrefetchHooks Function()
        > {
  $$DbMembershipsTableTableManager(_$AppDatabase db, $DbMembershipsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbMembershipsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbMembershipsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbMembershipsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> centerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> duration = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
              }) => DbMembershipsCompanion(
                id: id,
                centerId: centerId,
                name: name,
                price: price,
                description: description,
                duration: duration,
                imageUrl: imageUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int centerId,
                required String name,
                required double price,
                required String description,
                required String duration,
                Value<String> imageUrl = const Value.absent(),
              }) => DbMembershipsCompanion.insert(
                id: id,
                centerId: centerId,
                name: name,
                price: price,
                description: description,
                duration: duration,
                imageUrl: imageUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbMembershipsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbMembershipsTable,
      DbMembership,
      $$DbMembershipsTableFilterComposer,
      $$DbMembershipsTableOrderingComposer,
      $$DbMembershipsTableAnnotationComposer,
      $$DbMembershipsTableCreateCompanionBuilder,
      $$DbMembershipsTableUpdateCompanionBuilder,
      (
        DbMembership,
        BaseReferences<_$AppDatabase, $DbMembershipsTable, DbMembership>,
      ),
      DbMembership,
      PrefetchHooks Function()
    >;
typedef $$DbBookingsTableCreateCompanionBuilder =
    DbBookingsCompanion Function({
      Value<int> id,
      required String userId,
      required String contactName,
      Value<DateTime?> selectedDate,
      Value<String?> selectedTime,
      required String status,
      required double totalCost,
      required DateTime createdAt,
    });
typedef $$DbBookingsTableUpdateCompanionBuilder =
    DbBookingsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> contactName,
      Value<DateTime?> selectedDate,
      Value<String?> selectedTime,
      Value<String> status,
      Value<double> totalCost,
      Value<DateTime> createdAt,
    });

class $$DbBookingsTableFilterComposer
    extends Composer<_$AppDatabase, $DbBookingsTable> {
  $$DbBookingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get selectedDate => $composableBuilder(
    column: $table.selectedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedTime => $composableBuilder(
    column: $table.selectedTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbBookingsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbBookingsTable> {
  $$DbBookingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get selectedDate => $composableBuilder(
    column: $table.selectedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedTime => $composableBuilder(
    column: $table.selectedTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbBookingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbBookingsTable> {
  $$DbBookingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get contactName => $composableBuilder(
    column: $table.contactName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get selectedDate => $composableBuilder(
    column: $table.selectedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectedTime => $composableBuilder(
    column: $table.selectedTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DbBookingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbBookingsTable,
          DbBooking,
          $$DbBookingsTableFilterComposer,
          $$DbBookingsTableOrderingComposer,
          $$DbBookingsTableAnnotationComposer,
          $$DbBookingsTableCreateCompanionBuilder,
          $$DbBookingsTableUpdateCompanionBuilder,
          (
            DbBooking,
            BaseReferences<_$AppDatabase, $DbBookingsTable, DbBooking>,
          ),
          DbBooking,
          PrefetchHooks Function()
        > {
  $$DbBookingsTableTableManager(_$AppDatabase db, $DbBookingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbBookingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbBookingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbBookingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> contactName = const Value.absent(),
                Value<DateTime?> selectedDate = const Value.absent(),
                Value<String?> selectedTime = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbBookingsCompanion(
                id: id,
                userId: userId,
                contactName: contactName,
                selectedDate: selectedDate,
                selectedTime: selectedTime,
                status: status,
                totalCost: totalCost,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String contactName,
                Value<DateTime?> selectedDate = const Value.absent(),
                Value<String?> selectedTime = const Value.absent(),
                required String status,
                required double totalCost,
                required DateTime createdAt,
              }) => DbBookingsCompanion.insert(
                id: id,
                userId: userId,
                contactName: contactName,
                selectedDate: selectedDate,
                selectedTime: selectedTime,
                status: status,
                totalCost: totalCost,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbBookingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbBookingsTable,
      DbBooking,
      $$DbBookingsTableFilterComposer,
      $$DbBookingsTableOrderingComposer,
      $$DbBookingsTableAnnotationComposer,
      $$DbBookingsTableCreateCompanionBuilder,
      $$DbBookingsTableUpdateCompanionBuilder,
      (DbBooking, BaseReferences<_$AppDatabase, $DbBookingsTable, DbBooking>),
      DbBooking,
      PrefetchHooks Function()
    >;
typedef $$DbBookingItemsTableCreateCompanionBuilder =
    DbBookingItemsCompanion Function({
      Value<int> id,
      required int bookingId,
      required int membershipId,
      required int quantity,
      required double price,
    });
typedef $$DbBookingItemsTableUpdateCompanionBuilder =
    DbBookingItemsCompanion Function({
      Value<int> id,
      Value<int> bookingId,
      Value<int> membershipId,
      Value<int> quantity,
      Value<double> price,
    });

class $$DbBookingItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DbBookingItemsTable> {
  $$DbBookingItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bookingId => $composableBuilder(
    column: $table.bookingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get membershipId => $composableBuilder(
    column: $table.membershipId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbBookingItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbBookingItemsTable> {
  $$DbBookingItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bookingId => $composableBuilder(
    column: $table.bookingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get membershipId => $composableBuilder(
    column: $table.membershipId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbBookingItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbBookingItemsTable> {
  $$DbBookingItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bookingId =>
      $composableBuilder(column: $table.bookingId, builder: (column) => column);

  GeneratedColumn<int> get membershipId => $composableBuilder(
    column: $table.membershipId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);
}

class $$DbBookingItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbBookingItemsTable,
          DbBookingItem,
          $$DbBookingItemsTableFilterComposer,
          $$DbBookingItemsTableOrderingComposer,
          $$DbBookingItemsTableAnnotationComposer,
          $$DbBookingItemsTableCreateCompanionBuilder,
          $$DbBookingItemsTableUpdateCompanionBuilder,
          (
            DbBookingItem,
            BaseReferences<_$AppDatabase, $DbBookingItemsTable, DbBookingItem>,
          ),
          DbBookingItem,
          PrefetchHooks Function()
        > {
  $$DbBookingItemsTableTableManager(
    _$AppDatabase db,
    $DbBookingItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbBookingItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbBookingItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbBookingItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookingId = const Value.absent(),
                Value<int> membershipId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> price = const Value.absent(),
              }) => DbBookingItemsCompanion(
                id: id,
                bookingId: bookingId,
                membershipId: membershipId,
                quantity: quantity,
                price: price,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookingId,
                required int membershipId,
                required int quantity,
                required double price,
              }) => DbBookingItemsCompanion.insert(
                id: id,
                bookingId: bookingId,
                membershipId: membershipId,
                quantity: quantity,
                price: price,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbBookingItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbBookingItemsTable,
      DbBookingItem,
      $$DbBookingItemsTableFilterComposer,
      $$DbBookingItemsTableOrderingComposer,
      $$DbBookingItemsTableAnnotationComposer,
      $$DbBookingItemsTableCreateCompanionBuilder,
      $$DbBookingItemsTableUpdateCompanionBuilder,
      (
        DbBookingItem,
        BaseReferences<_$AppDatabase, $DbBookingItemsTable, DbBookingItem>,
      ),
      DbBookingItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DbFitnessCentersTableTableManager get dbFitnessCenters =>
      $$DbFitnessCentersTableTableManager(_db, _db.dbFitnessCenters);
  $$DbMembershipsTableTableManager get dbMemberships =>
      $$DbMembershipsTableTableManager(_db, _db.dbMemberships);
  $$DbBookingsTableTableManager get dbBookings =>
      $$DbBookingsTableTableManager(_db, _db.dbBookings);
  $$DbBookingItemsTableTableManager get dbBookingItems =>
      $$DbBookingItemsTableTableManager(_db, _db.dbBookingItems);
}
