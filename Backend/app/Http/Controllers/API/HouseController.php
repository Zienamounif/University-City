<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\House;
use App\Models\Student;
use App\Models\Temp;
use App\Models\Reglist;
use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

//Constants
const MALES_BUILDS = 5;
const FEMALES_BUILDS = 5;

const BUILD_FLOORS = 5;
const FLOOR_ROOMS = 10;
const ROOMS_BEDS = 5;
const DISABLED_PER_ROOM = 2;

const MALES_BUILDS_CAPACITY = MALES_BUILDS * BUILD_FLOORS * FLOOR_ROOMS * ROOMS_BEDS;
const FEMALES_BUILDS_CAPACITY = FEMALES_BUILDS * BUILD_FLOORS * FLOOR_ROOMS * ROOMS_BEDS;

const DEALY_ABILITY = 50;

const FEES = 50000;
const DISCOUNT = 5000;

const HOUSE_GOVERNORATE = "اللاذقية";

const HOUSE_START_DATE = "2023-11-15 00:00:00";
const HOUSE_END_DATE = "2023-11-30 00:00:00";
const HOUSE_REQUEST_DATE = "2023-11-20 00:00:00";

class HouseController extends Controller
{
    /**
     * Route: http://127.0.0.1:8000/api/view-houses
     * Method: get
     * Takes: no thing
     * Returns: all houses
     * Accessable: by admin role
     */
    public function viewHouses()
    {
        $houses = House::all();
        $result = [];

        for ($i = 0; $i < count($houses); $i++) {
            $houses[$i]->student = Student::find($houses[$i]->student_id);
            array_push($result, $houses[$i]);
        }

        $houses = $result;

        return response()->json([
            'houses' => $houses,
            'message' => 'Houses Fetched Successfully',
        ], 200);
    }

    /**
     * Route: http://127.0.0.1:8000/api/active-house
     * Method: post
     * Takes: house information
     * Returns: house
     * Accessable: by student role
     */

    public function activeHouse(Request $request)
    {
        $validationArray = [
            'first_name' => ['required', 'string', 'max:50'],
            'last_name' => ['required', 'string', 'max:50'],
            'gender' => ['required', 'string'],
            'father_name' => ['required', 'string', 'max:50'],
            'mother_name' => ['required', 'string', 'max:50'],
            'governorate' => ['required', 'string', 'max:50'],
            'phone' => ['required', 'string'], //'unique:students'
            'is_disabled' => ['required', 'string'],
            'collage' => ['required', 'string'],
            'collage_id' => ['required', 'string'], //'unique:students'
            'year' => ['required', 'string'],
            'is_successded' => ['required', 'string'],
            'student_id' => ['required', 'integer'],
        ];
        file_put_contents("test_is_protected.txt", json_encode($request->all()), FILE_APPEND);
        Student::find((int) $request->student_id)->update([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'gender' => $request->gender,
            'father_name' => $request->father_name,
            'mother_name' => $request->mother_name,
            'governorate' => $request->governorate,
            'phone' => $request->phone, //'unique:students'
            'is_disabled' => $request->is_disabled == "true" ? true : false,
            'collage' => $request->collage,
            'collage_id' => $request->collage_id, //'unique:students'
            'year' => $request->year,
            'is_successded' => $request->is_successded == "true" ? true : false,
        ]);

        $validator = Validator::make($request->all(), $validationArray);
        if ($validator->fails()) {
            return response()->json([
                'validation_errors' => $validator->errors(),
            ], 400);
        } else {
            $student = Student::find((int) $request->student_id);
            // if ($student) {
            //     $student->first_name = $request->input('first_name');
            //     $student->last_name = $request->input('last_name');
            //     $student->gender = $request->input('gender');
            //     $student->father_name = $request->input('father_name');
            //     $student->mother_name = $request->input('mother_name');
            //     $student->governorate = $request->input('governorate');
            //     $student->phone = $request->input('phone');
            //     $student->is_disabled = (boolean) $request->input('is_disabled');
            //     $student->collage = $request->input('collage');
            //     $student->collage_id = $request->input('collage_id');
            //     $student->year = $request->input('year');
            //     $student->is_successded = (boolean) $request->input('is_successded');
            //     $student->save();
            // }
        }

        // $request_date = new DateTime();
        $request_date = new DateTime(HOUSE_REQUEST_DATE);
        $start_date = new DateTime(HOUSE_START_DATE);
        $end_date = new DateTime(HOUSE_END_DATE);

        $diff = $start_date->diff($end_date);
        $diff_down = $request_date->diff($start_date);
        $diff_up = $request_date->diff($end_date);

        // return response()->json([
        //     'diff' => $diff,
        //     'diff_down' => $diff_down,
        //     'diff_up' => $diff_up
        // ], 200);ph

        if (
            $diff_down->invert === 1 && $diff_down->days <= $diff->days &&
            $diff_up->invert === 0 && $diff_up->days <= $diff->days
            // false
        ) {
            // Continue successful student
            // Stop failed student

            // Get authorized student
            $student = Student::find((int) $request->student_id);

            //If exsists in registeration lists
            $existsStudent = Reglist::where('collage_id', '=', $student->collage_id)->get();
            if (count($existsStudent) === 0) {
                return response()->json([
                    'message' => 'Student is not found in registeration lists',
                ], 404);
            }
            if ($existsStudent[0]->is_successded !== $student->is_successded) {
                return response()->json([
                    'message' => 'Make sure that you are either failed or successfull',
                ], 404);
            }

            if (!$student->is_successded) {
                $existsTemp = Temp::where('email', '=', $student->email)->get();
                if (count($existsTemp) === 0) {
                    Temp::create([
                        'student_id' => $student->id,
                        'first_name' => $student->first_name,
                        'last_name' => $student->last_name,
                        'gender' => $student->gender,
                        'father_name' => $student->father_name,
                        'mother_name' => $student->mother_name,
                        'governorate' => $student->governorate,
                        'email' => $student->email,
                        'phone' => $student->phone,
                        'is_disabled' => $student->is_disabled,
                        'collage' => $student->collage,
                        'collage_id' => $student->collage_id,
                        'year' => $student->year,
                        'is_successded' => $student->is_successded
                    ]);
                }
                return response()->json([
                    'message' => 'Student failed is unavailable now',
                ], 400);
            }
            file_put_contents("testjjjjj.txt", $student->is_disabled . " " . HOUSE_GOVERNORATE .  " " . $student->governorate, FILE_APPEND);
            if ($student->governorate == HOUSE_GOVERNORATE && $student->is_disabled == 0) {
                return response()->json([
                    'message' => 'Student governorate is unavailable',
                ], 400);
            }
            $existsStudent = House::where('student_id', '=', $student->id)->get();
            if (count($existsStudent) > 0) {
                return response()->json([
                    'house' => $existsStudent,
                    'message' => 'Student is already added',
                ], 400);
            }
            //Get student freind
            if ($student->is_disabled) {
                $validator = Validator::make($request->all(), [
                    'freind_collage_id' => ['string'],
                ]);
                if ($validator->fails()) {
                    return response()->json([
                        'validation_errors' => $validator->errors(),
                    ], 400);
                }
                if ($request->input('freind_collage_id')) {
                    $freindStudent = Student::where('collage_id', '=', $request->input('freind_collage_id'))->get();
                    if (count($freindStudent) === 0 && $student->is_disabled) {
                        return response()->json([
                            'message' => 'Freind is not found',
                        ], 400);
                    }
                    $freindStudent = House::where('student_id', '=', $freindStudent[0]->id)->get();
                    if (count($freindStudent) === 0) {
                        return response()->json([
                            'message' => 'Freind is not registered',
                        ], 400);
                    }
                    if (count($freindStudent) > 0 && $freindStudent[0]->gender !== $student->gender) {
                        return response()->json([
                            'message' => 'You and your friend are of different genders',
                        ], 400);
                    }
                    if (count($freindStudent) > 0 && $freindStudent[0]->is_protected) {
                        return response()->json([
                            'message' => 'Your freind is disabled',
                        ], 400);
                    }
                    if (count($freindStudent) > 0 && $freindStudent[0]->is_freind) {
                        return response()->json([
                            'message' => 'Your freind is freind to another one',
                        ], 400);
                    }
                }
            }

            //Get student registered brothers or sisters
            $studentBrothersAndSistersAlt = [];
            $studentBrothersAndSisters = Student::
                where('id', '!=', $student->id)->
                where('last_name', '=', $student->last_name)->
                where('father_name', '=', $student->father_name)->
                where('mother_name', '=', $student->mother_name)->
                where('governorate', '=', $student->governorate)->get();
            for ($i = 0; $i < count($studentBrothersAndSisters); $i++) {
                $registered = House::where('student_id', '=', $studentBrothersAndSisters[$i]->id)->get();
                if (count($registered)) {
                    array_push($studentBrothersAndSistersAlt, $studentBrothersAndSisters[$i]);
                }
            }
            $studentBrothersAndSisters = $studentBrothersAndSistersAlt;

            //Get current order
            $houses = House::where('type', '=', Str::camel(($student->gender)) . 's')->get();
            $curentHouse = count($houses) + 1;
            if ($student->gender == "male" && $curentHouse > MALES_BUILDS_CAPACITY) {
                return response()->json([
                    'message' => 'No place founds for you, capacity is full',
                ], 404);
            } else if ($student->gender == "female" && $curentHouse > FEMALES_BUILDS_CAPACITY) {
                return response()->json([
                    'message' => 'No place founds for you, capacity is full',
                ], 404);
            }

            //Add new order for any type of student (general, disabled, has brother or sisters)
            $house = new House;
            $house->type = Str::camel(($student->gender)) . 's';
            $house->build = (int) ((($curentHouse - 1) / (BUILD_FLOORS * FLOOR_ROOMS * ROOMS_BEDS)) + 1);
            $house->floor = (($curentHouse - 1) / (FLOOR_ROOMS * ROOMS_BEDS)) % BUILD_FLOORS + 1;
            $house->room = (($curentHouse - 1) / ROOMS_BEDS) % FLOOR_ROOMS + 1;
            $house->bed = ($curentHouse - 1) % ROOMS_BEDS + 1;
            $house->is_protected = $student->is_disabled ? 1 : 0;
            $house->is_freind = 0;
            $house->discount = (count($studentBrothersAndSisters) * DISCOUNT);
            $house->fees = (FEES - (count($studentBrothersAndSisters) * DISCOUNT));
            $house->student_id = $student->id;
            $house->status = "active";
            $house->save();

            //Get rooms (all rooms)
            $rooms = [];
            for ($i = 0; $i < $curentHouse; $i = $i + ROOMS_BEDS) {
                $houses = House::all();
                $room = House::
                    where('type', '=', $houses[$i]->type)->
                    where('build', '=', $houses[$i]->build)->
                    where('floor', '=', $houses[$i]->floor)->
                    where('room', '=', $houses[$i]->room)->get();
                array_push($rooms, $room);
            }

            //Get disabled rooms (with detect floors)
            $disabledRooms = [];
            for ($k = 0; $k < BUILD_FLOORS; $k++) {
                $disabledRooms_ = [];
                for ($i = 0; $i < count($rooms); $i++) {
                    $disabledCounter = 0;
                    for ($j = 0; $j < count($rooms[$i]); $j++) {
                        if ($rooms[$i][$j]->is_protected) {
                            $disabledCounter++;
                        }
                    }
                    if ($disabledCounter < DISABLED_PER_ROOM && $rooms[$i][0]->floor == $k + 1) {
                        if (count($rooms[$i]) == ROOMS_BEDS) {
                            array_push($disabledRooms_, $rooms[$i]);
                        }
                    }
                }

                $disabledRooms = $disabledRooms_;
                break;
            }

            //Disabled student
            if ($student->is_disabled && count($disabledRooms) > 0) {
                $firstRoom = $disabledRooms[0];

                $houseSwap = [];
                for ($i = 0; $i < count($firstRoom); $i++) {
                    if ($firstRoom[$i]->is_protected == false && $firstRoom[$i]->is_freind == false) {
                        $houseSwap = $firstRoom[$i];
                        break;
                    }
                }
                //return $houseSwap;

                if ($houseSwap) {
                    $temp = (House::where('student_id', '=', $student->id)->get())[0];
                    $houseOne = (House::where('student_id', '=', $student->id)->get())[0];
                    $houseTwo = $houseSwap;

                    $houseOne->fees = $houseTwo->fees;
                    $houseTwo->fees = $temp->fees;

                    $houseOne->discount = $houseTwo->discount;
                    $houseTwo->discount = $temp->discount;

                    $houseOne->is_protected = $houseTwo->is_protected;
                    $houseTwo->is_protected = $temp->is_protected;

                    $houseOne->student_id = $houseTwo->student_id;
                    $houseTwo->student_id = $temp->student_id;

                    $houseOne->save();
                    $houseTwo->save();

                    $house = $houseTwo;
                }

                if ($request->input('freind_collage_id')) {
                    $houseSwap = [];
                    for ($i = 0; $i < count($firstRoom); $i++) {
                        if ($firstRoom[$i]->is_protected == false && $firstRoom[$i]->is_freind == false) {
                            $houseSwap = $firstRoom[$i];
                            break;
                        }
                    }
                    //return $houseSwap;

                    if ($houseSwap) {
                        $freindStudent = Student::where('collage_id', '=', $request->input('freind_collage_id'))->get();

                        $temp = (House::where('student_id', '=', $freindStudent[0]->id)->get())[0];
                        $houseOne = (House::where('student_id', '=', $freindStudent[0]->id)->get())[0];
                        $houseTwo = $houseSwap;

                        $houseOne->fees = $houseTwo->fees;
                        $houseTwo->fees = $temp->fees;

                        $houseOne->discount = $houseTwo->discount;
                        $houseTwo->discount = $temp->discount;

                        $houseOne->is_protected = $houseTwo->is_protected;
                        $houseTwo->is_protected = $temp->is_protected;

                        $houseOne->student_id = $houseTwo->student_id;
                        $houseTwo->student_id = $temp->student_id;

                        $houseTwo->is_freind = 1;

                        $houseOne->save();
                        $houseTwo->save();
                    }
                }
            }
            //Get student brothers or sisters
            else {
                $brothersOrSistersAlt = [];
                $brothersOrSisters = Student::
                    where('id', '!=', $student->id)->
                    where('last_name', '=', $student->last_name)->
                    where('father_name', '=', $student->father_name)->
                    where('mother_name', '=', $student->mother_name)->
                    where('gender', '=', $student->gender)->
                    where('governorate', '=', $student->governorate)->get();

                for ($i = 0; $i < count($brothersOrSisters); $i++) {
                    $registered = House::where('student_id', '=', $brothersOrSisters[$i]->id)->get();
                    if (count($registered)) {
                        array_push($brothersOrSistersAlt, $brothersOrSisters[$i]);
                    }
                }
                $brothersOrSisters = $brothersOrSistersAlt;

                if (count($brothersOrSisters) > 0) {
                    $brotherOrSister = $brothersOrSisters[0];
                    $brotherOrSisterRoom = [];
                    for ($i = 0; $i < count($rooms); $i++) {
                        for ($j = 0; $j < count($rooms[$i]); $j++) {
                            if ($rooms[$i][$j]->student_id == $brotherOrSister->id) {
                                $brotherOrSisterRoom = count($rooms[$i]) == ROOMS_BEDS ? $rooms[$i] : [];
                                break;
                            }
                        }
                    }

                    $houseSwap = [];
                    for ($i = 0; $i < count($brotherOrSisterRoom); $i++) {
                        if (
                            $brotherOrSisterRoom[$i]->student_id != $brotherOrSister->id &&
                            $brotherOrSisterRoom[$i]->is_protected == 0 &&
                            $brotherOrSisterRoom[$i]->is_freind == false
                        ) {
                            $houseSwap = $brotherOrSisterRoom[$i];
                            break;
                        }
                    }
                    //return $houseSwap;

                    if ($houseSwap) {
                        $temp = (House::where('student_id', '=', $student->id)->get())[0];
                        $houseOne = (House::where('student_id', '=', $student->id)->get())[0];
                        $houseTwo = $houseSwap;

                        $houseOne->fees = $houseTwo->fees;
                        $houseTwo->fees = $temp->fees;

                        $houseOne->discount = $houseTwo->discount;
                        $houseTwo->discount = $temp->discount;

                        $houseOne->student_id = $houseTwo->student_id;
                        $houseTwo->student_id = $temp->student_id;

                        $houseOne->save();
                        $houseTwo->save();

                        $house = $houseTwo;
                    }
                }
            }

            return response()->json([
                'house' => [$house],
                'review_date' => (int) (count($houses) / DEALY_ABILITY),
                'message' => 'House Added Successfully',
            ], 201);
        } else {
            // Stop successful student
            // Stop failed student

            $temps = Temp::all()->groupBy('gender');
            if (!$temps->get('male')) {
                $temps['male'] = [];
            }
            if (!$temps->get('female')) {
                $temps['female'] = [];
            }
            $houses = House::all()->groupBy('type');
            if (!$houses->get('males')) {
                $houses['males'] = [];
            }
            if (!$houses->get('females')) {
                $houses['females'] = [];
            }

            if (
                (count($temps->get('male')) > 0 && count($houses->get('males')) <= MALES_BUILDS_CAPACITY)
            ) {
                //Add to houses
                $maleIterations = 0;
                if (count($temps->get('male')) > (MALES_BUILDS_CAPACITY - count($houses->get('males')))) {
                    $maleIterations = (MALES_BUILDS_CAPACITY - count($houses->get('males')));
                } else if (count($temps->get('male')) < (MALES_BUILDS_CAPACITY - count($houses->get('males')))) {
                    $maleIterations = count($temps->get('male'));
                } else {
                    $maleIterations = count($temps->get('male'));
                }
                for ($i = 0; $i < $maleIterations; $i++) {
                    //Get current order
                    $houses = House::where('type', '=', Str::camel((($temps->get('male')[$i])->gender)) . 's')->get();
                    $curentHouse = count($houses) + 1;
                    if (($temps->get('male')[$i])->gender == "male" && $curentHouse > MALES_BUILDS_CAPACITY) {
                        return response()->json([
                            'message' => 'No place founds for you, capacity is full',
                        ], 404);
                    } else if (($temps->get('male')[$i])->gender == "female" && $curentHouse > FEMALES_BUILDS_CAPACITY) {
                        return response()->json([
                            'message' => 'No place founds for you, capacity is full',
                        ], 404);
                    }

                    //Add new order for any type of student (general, disabled, has brother or sisters)
                    $house = new House;
                    $house->type = Str::camel((($temps->get('male')[$i])->gender)) . 's';
                    $house->build = (int) ((($curentHouse - 1) / (BUILD_FLOORS * FLOOR_ROOMS * ROOMS_BEDS)) + 1);
                    $house->floor = (($curentHouse - 1) / (FLOOR_ROOMS * ROOMS_BEDS)) % BUILD_FLOORS + 1;
                    $house->room = (($curentHouse - 1) / ROOMS_BEDS) % FLOOR_ROOMS + 1;
                    $house->bed = ($curentHouse - 1) % ROOMS_BEDS + 1;
                    $house->is_protected = ($temps->get('male')[$i])->is_disabled ? 1 : 0;
                    $house->is_freind = 0;
                    $house->discount = 0;
                    $house->fees = FEES;
                    $house->student_id = ($temps->get('male')[$i])->student_id;
                    $house->status = "active";
                    $house->save();
                }

                for ($i = 0; $i < count($temps->get('male')); $i++) {
                    ($temps->get('male')[$i])->delete();
                }
            }
            if (
                (count($temps->get('female')) > 0 && count($houses->get('females')) <= FEMALES_BUILDS_CAPACITY)
            ) {
                //Add to houses
                $femaleIterations = 0;
                if (count($temps->get('female')) > (MALES_BUILDS_CAPACITY - count($houses->get('females')))) {
                    $femaleIterations = (MALES_BUILDS_CAPACITY - count($houses->get('females')));
                } else if (count($temps->get('female')) < (MALES_BUILDS_CAPACITY - count($houses->get('females')))) {
                    $femaleIterations = count($temps->get('female'));
                } else {
                    $femaleIterations = count($temps->get('female'));
                }
                for ($i = 0; $i < $femaleIterations; $i++) {
                    //Get current order
                    $houses = House::where('type', '=', Str::camel((($temps->get('female')[$i])->gender)) . 's')->get();
                    $curentHouse = count($houses) + 1;
                    if (($temps->get('female')[$i])->gender == "female" && $curentHouse > MALES_BUILDS_CAPACITY) {
                        return response()->json([
                            'message' => 'No place founds for you, capacity is full',
                        ], 404);
                    } else if (($temps->get('female')[$i])->gender == "female" && $curentHouse > FEMALES_BUILDS_CAPACITY) {
                        return response()->json([
                            'message' => 'No place founds for you, capacity is full',
                        ], 404);
                    }

                    //Add new order for any type of student (general, disabled, has brother or sisters)
                    $house = new House;
                    $house->type = Str::camel((($temps->get('female')[$i])->gender)) . 's';
                    $house->build = (int) ((($curentHouse - 1) / (BUILD_FLOORS * FLOOR_ROOMS * ROOMS_BEDS)) + 1);
                    $house->floor = (($curentHouse - 1) / (FLOOR_ROOMS * ROOMS_BEDS)) % BUILD_FLOORS + 1;
                    $house->room = (($curentHouse - 1) / ROOMS_BEDS) % FLOOR_ROOMS + 1;
                    $house->bed = ($curentHouse - 1) % ROOMS_BEDS + 1;
                    $house->is_protected = ($temps->get('female')[$i])->is_disabled ? 1 : 0;
                    $house->is_freind = 0;
                    $house->discount = 0;
                    $house->fees = FEES;
                    $house->student_id = ($temps->get('female')[$i])->student_id;
                    $house->status = "active";
                    $house->save();
                }

                for ($i = 0; $i < count($temps->get('male')); $i++) {
                    ($temps->get('male')[$i])->delete();
                }
            }

            $student = Student::find((int) $request->student_id);
            if (!$student->is_successded) {
                $existsStudent = House::where('student_id', '=', $student->id)->get();
                if (count($existsStudent) > 0) {
                    return response()->json([
                        'house' => $existsStudent,
                        'message' => 'House Added Successfully',
                    ], 200);
                } else {
                    return response()->json([
                        'message' => 'House Did Not Added Successfully',
                    ], 400);
                }
            }

            return response()->json([
                'message' => "Housing Time Is Finished ",
            ], 400);
        }
    }

    /**
     * Route: http://127.0.0.1:8000/api/passive-house
     * Method: put
     * Takes: house id
     * Returns: house
     * Accessable: by admin and student roles
     */
    public function passiveHouse($id)
    {
        $house = House::find($id);
        if ($house) {
            $house->status = "passive";

            $house->save();
            return response()->json([
                'house' => $house,
                'message' => 'House Updated Successfully',
            ], 200);
        } else {
            return response()->json([
                'message' => 'No House Id Found',
            ], 404);
        }
    }
}
