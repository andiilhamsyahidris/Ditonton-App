
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSourceImpl;
  late MockDatabaseHelperTv mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelperTv = MockDatabaseHelperTv();
    dataSourceImpl =
        TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelperTv);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      final result = await dataSourceImpl.insertWatchlistTv(testTvTable);
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());
      final call = dataSourceImpl.insertWatchlistTv(testTvTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelperTv.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      final result = await dataSourceImpl.removeWatchlistTv(testTvTable);
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDatabaseHelperTv.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());
      final call = dataSourceImpl.removeWatchlistTv(testTvTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series Detail By Id', () {
    final tId = 1;

    test('should return Tv Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSourceImpl.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSourceImpl.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelperTv.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSourceImpl.getWatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
