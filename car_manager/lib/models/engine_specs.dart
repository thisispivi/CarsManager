class EngineSpecs {
  final EngineType? type;
  final int? displacement;
  final FuelType? fuelType;
  final int? maxPower;
  final int? horsePower;
  final int? engineSpeed;
  final int? maxTorque;
  final DriveType? driveType;
  final TransmissionType? transmissionType;
  final int? gears;

  EngineSpecs({
    this.type,
    this.displacement,
    this.fuelType,
    this.maxPower,
    this.horsePower,
    this.engineSpeed,
    this.maxTorque,
    this.driveType,
    this.transmissionType,
    this.gears,
  });
}

enum EngineType { fourCylinderInline, sixCylinderInline, v6, v8, v12 }

enum FuelType { petrol, diesel, electric, hybrid }

enum DriveType { fwd, rwd, awd, fourWheelDrive }

enum TransmissionType { manual, automatic, semiAutomatic }
