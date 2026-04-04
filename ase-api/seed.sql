-- Clear out old data so we don't get duplicates
TRUNCATE TABLE question_choices, questions CASCADE;

-- ==========================================
-- A1: Engine Repair (Additional Questions)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A vacuum gauge connected to the intake manifold shows a steady reading of 10 in. Hg at idle. What does this indicate?', 'A steady but low vacuum reading (normal is 17-21 in. Hg) usually indicates late ignition timing or late valve timing.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Normal engine operation', FALSE),
((SELECT MAX(id) FROM questions), 'Late ignition or valve timing', TRUE),
((SELECT MAX(id) FROM questions), 'A burned exhaust valve', FALSE),
((SELECT MAX(id) FROM questions), 'A weak cylinder', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When measuring a cylinder bore for wear, where is the most wear typically found?', 'The most wear in a cylinder bore occurs at the top of the ring travel, just below the ridge, perpendicular to the crankshaft (thrust surface).', 'Engine Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'At the bottom of the cylinder', FALSE),
((SELECT MAX(id) FROM questions), 'In the middle of the cylinder', FALSE),
((SELECT MAX(id) FROM questions), 'At the top of the ring travel', TRUE),
((SELECT MAX(id) FROM questions), 'Parallel to the crankshaft', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'During a stall test, the engine RPM exceeds the maximum specification. What does this indicate?', 'If the engine RPM goes above the specified stall speed, it means the transmission clutches or bands are slipping.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Slipping transmission clutches or bands', TRUE),
((SELECT MAX(id) FROM questions), 'A slipping torque converter stator clutch', FALSE),
((SELECT MAX(id) FROM questions), 'Poor engine performance', FALSE),
((SELECT MAX(id) FROM questions), 'Normal operation', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'Technician A says a misadjusted throttle valve (TV) cable can cause harsh shifting. Technician B says it can cause early shifting. Who is right?', 'A misadjusted TV cable can cause line pressure to be too high (harsh, late shifts) or too low (soft, early shifts).', 'Transmission Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A customer complains of a growling noise that goes away when the clutch pedal is depressed. What is the most likely cause?', 'If the noise goes away when the clutch pedal is depressed (disconnecting the transmission input shaft from the engine), the input shaft bearing is the likely culprit.', 'Clutch Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A bad throw-out (release) bearing', FALSE),
((SELECT MAX(id) FROM questions), 'A bad pilot bearing', FALSE),
((SELECT MAX(id) FROM questions), 'A bad transmission input shaft bearing', TRUE),
((SELECT MAX(id) FROM questions), 'A warped clutch disc', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'When setting the backlash on a ring and pinion gear, moving the ring gear closer to the pinion gear will:', 'Moving the ring gear closer to the pinion gear decreases the clearance (backlash) between the gear teeth.', 'Axle Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Increase backlash', FALSE),
((SELECT MAX(id) FROM questions), 'Decrease backlash', TRUE),
((SELECT MAX(id) FROM questions), 'Move the pinion deeper', FALSE),
((SELECT MAX(id) FROM questions), 'Have no effect on backlash', FALSE);

-- ==========================================
-- A4: Suspension & Steering
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle has excessive play in the steering wheel. Technician A says worn tie rod ends could be the cause. Technician B says a worn steering gear could be the cause. Who is right?', 'Both worn tie rod ends and a worn steering gear (rack and pinion or recirculating ball) will cause excessive free play in the steering wheel.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Which alignment angle is most likely to cause tire wear on the inside edge of both front tires?', 'Excessive negative camber causes the vehicle weight to rest on the inside edge of the tires, leading to rapid wear on that edge.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Excessive positive camber', FALSE),
((SELECT MAX(id) FROM questions), 'Excessive negative camber', TRUE),
((SELECT MAX(id) FROM questions), 'Excessive positive caster', FALSE),
((SELECT MAX(id) FROM questions), 'Excessive toe-in', FALSE);

-- ==========================================
-- A5: Brakes
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle pulls to the left only when the brakes are applied. What is the most likely cause?', 'A restricted brake hose on the right side will prevent hydraulic pressure from reaching the right caliper, causing the vehicle to pull to the left (the side that is working).', 'Brake Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted right front brake hose', TRUE),
((SELECT MAX(id) FROM questions), 'A restricted left front brake hose', FALSE),
((SELECT MAX(id) FROM questions), 'A seized left front caliper', FALSE),
((SELECT MAX(id) FROM questions), 'Air in the left front brake line', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When measuring a brake rotor for thickness variation (parallelism), a micrometer should be used to measure the rotor at:', 'Thickness variation must be measured at multiple points (usually 6 to 8) around the circumference of the rotor to check for variations that cause brake pulsation.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'One point on the outer edge', FALSE),
((SELECT MAX(id) FROM questions), 'Two points directly across from each other', FALSE),
((SELECT MAX(id) FROM questions), 'Several points around the circumference', TRUE),
((SELECT MAX(id) FROM questions), 'The center hub only', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When performing a voltage drop test on the starter ground circuit, the voltmeter should be connected between the:', 'To test the ground circuit voltage drop, connect the voltmeter between the negative battery post and the starter motor housing while cranking the engine.', 'Starting System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Positive battery post and the starter B+ terminal', FALSE),
((SELECT MAX(id) FROM questions), 'Negative battery post and the starter housing', TRUE),
((SELECT MAX(id) FROM questions), 'Starter B+ terminal and the starter housing', FALSE),
((SELECT MAX(id) FROM questions), 'Positive battery post and the negative battery post', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A turn signal flashes rapidly on the left side but normally on the right side. What is the most likely cause?', 'A burned-out bulb reduces the resistance in the flasher circuit, causing the thermal flasher to heat up and break the circuit faster, resulting in a rapid flash rate.', 'Lighting Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty flasher relay', FALSE),
((SELECT MAX(id) FROM questions), 'A burned-out left turn signal bulb', TRUE),
((SELECT MAX(id) FROM questions), 'A short to ground in the right turn signal circuit', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty turn signal switch', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'Which component in the A/C system is responsible for removing moisture from the refrigerant?', 'The receiver-drier (or accumulator) contains desiccant, which absorbs moisture from the refrigerant to prevent ice formation and corrosion.', 'A/C System Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The condenser', FALSE),
((SELECT MAX(id) FROM questions), 'The evaporator', FALSE),
((SELECT MAX(id) FROM questions), 'The receiver-drier', TRUE),
((SELECT MAX(id) FROM questions), 'The expansion valve', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A heater blows cold air at idle but warm air when driving at highway speeds. What is the most likely cause?', 'Low engine coolant level will cause poor heater performance at idle because the water pump cannot circulate enough hot coolant to the heater core at low RPMs.', 'Heating System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A stuck open thermostat', FALSE),
((SELECT MAX(id) FROM questions), 'Low engine coolant level', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty blend door actuator', FALSE),
((SELECT MAX(id) FROM questions), 'A clogged A/C evaporator', FALSE);

-- ==========================================
-- A8: Engine Performance
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A vehicle has a misfire on cylinder #3. Swapping the ignition coil with cylinder #2 causes the misfire to move to cylinder #2. What is the cause?', 'Because the misfire followed the ignition coil to the new cylinder, the coil itself is proven to be defective.', 'Ignition System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty spark plug on cylinder #3', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty fuel injector on cylinder #2', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty ignition coil', TRUE),
((SELECT MAX(id) FROM questions), 'Low compression on cylinder #3', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'Which sensor is considered the primary input for determining base fuel delivery on a fuel-injected engine?', 'The Mass Air Flow (MAF) sensor or Manifold Absolute Pressure (MAP) sensor is the primary input the PCM uses to calculate the base pulse width for fuel injectors.', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Oxygen (O2) sensor', FALSE),
((SELECT MAX(id) FROM questions), 'Mass Air Flow (MAF) sensor', TRUE),
((SELECT MAX(id) FROM questions), 'Engine Coolant Temperature (ECT) sensor', FALSE),
((SELECT MAX(id) FROM questions), 'Throttle Position Sensor (TPS)', FALSE);

-- ==========================================
-- A1: Engine Repair
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A vehicle emits blue smoke from the tailpipe only upon deceleration. What is the most likely cause?', 'High intake manifold vacuum during deceleration pulls oil past worn valve guide seals into the combustion chamber.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn piston rings', FALSE),
((SELECT MAX(id) FROM questions), 'Worn valve guide seals', TRUE),
((SELECT MAX(id) FROM questions), 'A blown head gasket', FALSE),
((SELECT MAX(id) FROM questions), 'A rich fuel mixture', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When checking a cylinder head for warpage, which tools should be used?', 'A precision straightedge and a feeler gauge are used to check the deck surface of a cylinder head or engine block for warpage.', 'Engine Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A dial indicator and a micrometer', FALSE),
((SELECT MAX(id) FROM questions), 'A straightedge and a feeler gauge', TRUE),
((SELECT MAX(id) FROM questions), 'A vernier caliper and a straightedge', FALSE),
((SELECT MAX(id) FROM questions), 'A machinist square and a dial caliper', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'An automatic transmission fluid (ATF) sample is dark brown and has a burnt odor. What does this indicate?', 'Dark, burnt-smelling ATF is a strong indicator that the internal friction materials (clutches or bands) are slipping and overheating.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Normal fluid degradation over time', FALSE),
((SELECT MAX(id) FROM questions), 'Coolant mixing with the ATF', FALSE),
((SELECT MAX(id) FROM questions), 'Slipping clutches or bands', TRUE),
((SELECT MAX(id) FROM questions), 'Aeration from overfilling', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A vehicle experiences a severe shudder only when the torque converter clutch (TCC) engages. What is the most likely cause?', 'TCC shudder is typically caused by degraded transmission fluid or worn friction material on the torque converter clutch itself.', 'Torque Converter Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A broken planetary gearset', FALSE),
((SELECT MAX(id) FROM questions), 'Worn TCC friction material or degraded fluid', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty shift solenoid', FALSE),
((SELECT MAX(id) FROM questions), 'Low line pressure', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A manual transmission is difficult to shift into all forward gears while the engine is running, but shifts easily when the engine is off. What is the most likely cause?', 'If the transmission shifts fine with the engine off but grinds or is hard to shift with the engine running, the clutch is not fully releasing (dragging).', 'Clutch Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn synchronizer rings', FALSE),
((SELECT MAX(id) FROM questions), 'A dragging clutch', TRUE),
((SELECT MAX(id) FROM questions), 'Low transmission fluid', FALSE),
((SELECT MAX(id) FROM questions), 'Worn shift forks', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A whining noise is heard in all forward gears except 4th gear (which is a 1:1 ratio). What is the most likely cause?', 'In a 1:1 ratio (usually 4th gear), power flows straight through the main shaft, bypassing the countershaft. If the noise disappears in this gear, the countershaft bearings are worn.', 'Transmission Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn input shaft bearing', FALSE),
((SELECT MAX(id) FROM questions), 'Worn countershaft bearings', TRUE),
((SELECT MAX(id) FROM questions), 'Worn output shaft bearing', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty pilot bearing', FALSE);

-- ==========================================
-- A4: Suspension & Steering
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle exhibits "memory steer" (the steering wheel fails to return to center after a turn and pulls in the direction of the last turn). What is the most likely cause?', 'Memory steer is caused by binding in the steering or suspension components, most commonly a binding upper strut mount bearing or ball joint.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Incorrect toe setting', FALSE),
((SELECT MAX(id) FROM questions), 'A binding strut mount bearing', TRUE),
((SELECT MAX(id) FROM questions), 'Worn sway bar bushings', FALSE),
((SELECT MAX(id) FROM questions), 'Low power steering fluid', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Inspection of a tire reveals a cupped (scalloped) wear pattern around the tread. What is the most likely cause?', 'Cupping is caused by the tire bouncing up and down as it rolls down the road, which is a direct result of worn or defective shock absorbers/struts.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Excessive toe-in', FALSE),
((SELECT MAX(id) FROM questions), 'Worn shock absorbers', TRUE),
((SELECT MAX(id) FROM questions), 'Underinflation', FALSE),
((SELECT MAX(id) FROM questions), 'Excessive negative camber', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'After replacing the outer tie rod ends, the steering wheel is off-center when driving straight. What needs to be adjusted?', 'The tie rod sleeves must be adjusted to center the steering wheel while setting the total toe specification.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Camber', FALSE),
((SELECT MAX(id) FROM questions), 'Caster', FALSE),
((SELECT MAX(id) FROM questions), 'Toe', TRUE),
((SELECT MAX(id) FROM questions), 'Steering axis inclination (SAI)', FALSE);

-- ==========================================
-- A5: Brakes
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A customer complains of a hard brake pedal and poor stopping power. Technician A says a faulty brake booster could be the cause. Technician B says a vacuum leak could be the cause. Who is right?', 'Both a faulty brake booster (ruptured diaphragm) and a vacuum leak (loss of vacuum supply to the booster) will result in a loss of power assist, causing a hard pedal.', 'Brake Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'The ABS warning light is illuminated, but the red brake warning light is off. The vehicle stops normally during regular braking. What is the most likely cause?', 'If the red brake light is off, base hydraulic braking is functioning. An illuminated ABS light indicates a fault in the anti-lock system, such as a faulty wheel speed sensor.', 'Electronic Brake Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Low brake fluid level', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty wheel speed sensor', TRUE),
((SELECT MAX(id) FROM questions), 'A leaking master cylinder', FALSE),
((SELECT MAX(id) FROM questions), 'Worn brake pads', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When performing a voltage drop test across a closed switch in a working circuit, what is the maximum acceptable reading?', 'A good switch or connection should have virtually no resistance, resulting in a voltage drop of less than 0.1 to 0.2 volts.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), '0.1 volts', TRUE),
((SELECT MAX(id) FROM questions), '1.0 volts', FALSE),
((SELECT MAX(id) FROM questions), '5.0 volts', FALSE),
((SELECT MAX(id) FROM questions), '12.0 volts', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A starter motor clicks rapidly but does not crank the engine. What is the most likely cause?', 'A rapid clicking noise usually indicates that there is enough voltage to pull the starter solenoid in, but the voltage drops too low under the heavy load of the starter motor, causing the solenoid to release and re-engage rapidly. This is typically caused by a weak battery or poor battery connections.', 'Starting Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty ignition switch', FALSE),
((SELECT MAX(id) FROM questions), 'An open neutral safety switch', FALSE),
((SELECT MAX(id) FROM questions), 'A weak battery or loose battery terminals', TRUE),
((SELECT MAX(id) FROM questions), 'A seized engine', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'In a series circuit with three bulbs, what happens if one bulb burns out (creates an open circuit)?', 'In a series circuit, there is only one path for current to flow. If the path is broken (open circuit), current stops flowing entirely, and all bulbs will go out.', 'Electrical Fundamentals', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The other two bulbs get brighter', FALSE),
((SELECT MAX(id) FROM questions), 'The other two bulbs get dimmer', FALSE),
((SELECT MAX(id) FROM questions), 'All bulbs go out', TRUE),
((SELECT MAX(id) FROM questions), 'The circuit blows a fuse', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A customer complains of a musty odor coming from the A/C vents when the system is first turned on. What is the most likely cause?', 'A musty odor is typically caused by mold or mildew growing on the evaporator core, often exacerbated by a clogged evaporator drain tube.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A leaking heater core', FALSE),
((SELECT MAX(id) FROM questions), 'Mold growth on the evaporator core', TRUE),
((SELECT MAX(id) FROM questions), 'A slipping compressor clutch', FALSE),
((SELECT MAX(id) FROM questions), 'Low refrigerant charge', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'During an A/C performance test, frost is observed on the line exiting the expansion valve. Technician A says this is normal. Technician B says the system is overcharged. Who is right?', 'Frost on the expansion valve or evaporator inlet indicates a restriction or a low refrigerant charge causing the pressure to drop too low, freezing the moisture in the air. It is not normal.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', TRUE);

-- ==========================================
-- A8: Engine Performance
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A scan tool retrieves a P0300 Diagnostic Trouble Code (DTC). What does this code indicate?', 'P0300 is the generic OBD-II code for a Random/Multiple Cylinder Misfire detected.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Misfire on cylinder #3', FALSE),
((SELECT MAX(id) FROM questions), 'Random/Multiple cylinder misfire', TRUE),
((SELECT MAX(id) FROM questions), 'Catalytic converter efficiency below threshold', FALSE),
((SELECT MAX(id) FROM questions), 'Evaporative emission system leak', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'An upstream Oxygen (O2) sensor voltage is stuck at 0.900 volts. What does this indicate?', 'A conventional zirconia O2 sensor produces voltage between 0.1V (lean) and 0.9V (rich). A steady 0.9V indicates a constant rich exhaust condition.', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A lean exhaust condition', FALSE),
((SELECT MAX(id) FROM questions), 'A rich exhaust condition', TRUE),
((SELECT MAX(id) FROM questions), 'A stoichiometric air/fuel ratio', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty catalytic converter', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'Technician A says a clogged catalytic converter can cause low engine vacuum at idle. Technician B says a clogged catalytic converter can cause a lack of engine power at highway speeds. Who is right?', 'A restricted exhaust (clogged converter) creates backpressure, which reduces intake vacuum and severely limits high-RPM engine power.', 'Exhaust System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'When testing a Mass Air Flow (MAF) sensor with a scan tool, the grams per second (g/s) reading should:', 'As the throttle is opened and engine RPM increases, more air enters the engine, so the MAF sensor reading should increase smoothly and proportionally.', 'Air Induction Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Decrease as engine RPM increases', FALSE),
((SELECT MAX(id) FROM questions), 'Remain constant regardless of engine RPM', FALSE),
((SELECT MAX(id) FROM questions), 'Increase as engine RPM increases', TRUE),
((SELECT MAX(id) FROM questions), 'Drop to zero during wide-open throttle', FALSE);

-- ==========================================
-- A1: Engine Repair
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Technician A says low engine oil pressure can be caused by worn main bearings. Technician B says a stuck open oil pump relief valve can cause low oil pressure. Who is right?', 'Both worn main bearings (excessive clearance) and a stuck open oil pressure relief valve will cause a drop in engine oil pressure.', 'Lubrication Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When installing a timing belt, the engine should typically be set to:', 'Timing belts are almost always installed with the engine set to Top Dead Center (TDC) on the compression stroke for cylinder number 1.', 'Engine Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Bottom Dead Center (BDC) on cylinder 1', FALSE),
((SELECT MAX(id) FROM questions), 'Top Dead Center (TDC) on the exhaust stroke for cylinder 1', FALSE),
((SELECT MAX(id) FROM questions), 'Top Dead Center (TDC) on the compression stroke for cylinder 1', TRUE),
((SELECT MAX(id) FROM questions), '10 degrees Before Top Dead Center (BTDC)', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A line pressure test is being performed on an automatic transmission. The pressure is normal at idle but does not increase when the throttle is opened. What is the most likely cause?', 'If line pressure does not rise with throttle opening, the Electronic Pressure Control (EPC) solenoid or the throttle valve linkage/cable is likely faulty.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty oil pump', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty Electronic Pressure Control (EPC) solenoid', TRUE),
((SELECT MAX(id) FROM questions), 'A clogged transmission filter', FALSE),
((SELECT MAX(id) FROM questions), 'Worn forward clutch plates', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'In a simple planetary gearset, if the sun gear is the input, the ring gear is held stationary, and the planetary carrier is the output, what is the result?', 'Driving the sun gear while holding the ring gear forces the carrier to walk around the inside of the ring gear, resulting in forward gear reduction (lower speed, higher torque).', 'Planetary Gearsets', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Direct drive (1:1 ratio)', FALSE),
((SELECT MAX(id) FROM questions), 'Overdrive', FALSE),
((SELECT MAX(id) FROM questions), 'Reverse', FALSE),
((SELECT MAX(id) FROM questions), 'Forward gear reduction', TRUE);

-- ==========================================
-- A3: Manual Drive Train & Axles
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'Insufficient clutch pedal free play can cause:', 'If there is not enough free play, the release bearing may constantly ride against the pressure plate fingers, causing the clutch to slip and wear prematurely.', 'Clutch Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Gear clash when shifting', FALSE),
((SELECT MAX(id) FROM questions), 'Clutch slippage', TRUE),
((SELECT MAX(id) FROM questions), 'A hard clutch pedal', FALSE),
((SELECT MAX(id) FROM questions), 'Transmission fluid leaks', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A 4WD vehicle makes a loud popping noise from the transfer case when accelerating hard under a heavy load. What is the most likely cause?', 'A stretched transfer case drive chain will jump teeth on the sprockets under heavy load, causing a loud popping or snapping noise.', 'Transfer Case Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A stretched transfer case chain', TRUE),
((SELECT MAX(id) FROM questions), 'Low transfer case fluid', FALSE),
((SELECT MAX(id) FROM questions), 'Worn locking hubs', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty shift motor', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'When replacing a two-piece driveshaft, why is it important to mark the slip yoke and driveshaft splines before disassembly?', 'The driveshaft is balanced as an assembly. If the slip yoke is not installed in the exact same phase (spline alignment), it will cause a driveline vibration.', 'Driveshaft Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To ensure proper U-joint lubrication', FALSE),
((SELECT MAX(id) FROM questions), 'To maintain proper driveline phasing and balance', TRUE),
((SELECT MAX(id) FROM questions), 'To prevent transmission fluid loss', FALSE),
((SELECT MAX(id) FROM questions), 'To set the correct pinion angle', FALSE);

-- ==========================================
-- A4: Suspension & Steering
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A power steering system emits a loud whining noise that increases with engine RPM. The fluid level is full, but the fluid is full of tiny bubbles. What is the most likely cause?', 'Air entering the suction side of the power steering pump (often through a loose hose or bad O-ring) causes aeration, resulting in a loud whine.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted high-pressure hose', FALSE),
((SELECT MAX(id) FROM questions), 'Air entering the suction side of the pump', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty steering gear spool valve', FALSE),
((SELECT MAX(id) FROM questions), 'Worn inner tie rod ends', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Adjusting the torsion bars on a vehicle equipped with a torsion bar front suspension will directly affect:', 'Torsion bars act as the front springs. Adjusting the torsion bar keys directly changes the vehicle''s ride height.', 'Suspension Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Caster only', FALSE),
((SELECT MAX(id) FROM questions), 'Ride height', TRUE),
((SELECT MAX(id) FROM questions), 'Steering axis inclination (SAI)', FALSE),
((SELECT MAX(id) FROM questions), 'Turning radius', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Which of the following alignment angles is NOT adjustable on most MacPherson strut front suspensions?', 'On most standard MacPherson strut suspensions, Caster is built into the strut tower and lower control arm mounting points and is not adjustable without aftermarket kits.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Toe', FALSE),
((SELECT MAX(id) FROM questions), 'Camber', FALSE),
((SELECT MAX(id) FROM questions), 'Caster', TRUE),
((SELECT MAX(id) FROM questions), 'Steering wheel center', FALSE);

-- ==========================================
-- A5: Brakes
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Which tool should be used to measure the lateral runout of a brake rotor?', 'A dial indicator is the correct tool for measuring lateral runout (warpage) on a brake rotor.', 'Brake Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'An outside micrometer', FALSE),
((SELECT MAX(id) FROM questions), 'A dial indicator', TRUE),
((SELECT MAX(id) FROM questions), 'A vernier caliper', FALSE),
((SELECT MAX(id) FROM questions), 'A straightedge and feeler gauge', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the primary function of the proportioning valve in a non-ABS brake system?', 'The proportioning valve limits hydraulic pressure to the rear drum brakes during hard stops to prevent rear wheel lockup and vehicle spinout.', 'Hydraulic System', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To hold pressure in the rear lines to keep wheel cylinders expanded', FALSE),
((SELECT MAX(id) FROM questions), 'To delay front brake application until rear shoes contact the drums', FALSE),
((SELECT MAX(id) FROM questions), 'To limit pressure to the rear brakes during hard braking', TRUE),
((SELECT MAX(id) FROM questions), 'To warn the driver of a hydraulic leak', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Technician A says DOT 3 brake fluid is silicone-based. Technician B says DOT 5 brake fluid absorbs moisture from the air. Who is right?', 'Neither is right. DOT 3 is glycol-based and absorbs moisture (hygroscopic). DOT 5 is silicone-based and does NOT absorb moisture.', 'Brake Fluid', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', TRUE);

-- ==========================================
-- A6: Electrical/Electronic Systems
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When testing a standard 4-pin ISO relay, which two terminals connect to the electromagnetic coil?', 'Terminals 85 and 86 are the control circuit (coil) of a standard ISO relay. Terminals 30 and 87 are the switch contacts.', 'Electrical Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), '30 and 87', FALSE),
((SELECT MAX(id) FROM questions), '85 and 86', TRUE),
((SELECT MAX(id) FROM questions), '30 and 87a', FALSE),
((SELECT MAX(id) FROM questions), '86 and 87', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'An alternator is being tested with a digital multimeter set to AC volts. The reading at the B+ terminal is 0.8 volts AC. What does this indicate?', 'An AC voltage reading above 0.5V at the alternator output indicates that one or more diodes in the rectifier bridge have failed, allowing AC ripple into the DC system.', 'Charging Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Normal alternator operation', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty voltage regulator', FALSE),
((SELECT MAX(id) FROM questions), 'Failed diodes in the rectifier bridge', TRUE),
((SELECT MAX(id) FROM questions), 'A slipping drive belt', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When measuring the resistance of a High-Speed CAN bus network at the DLC with the battery disconnected, a reading of 60 ohms indicates:', 'A High-Speed CAN bus has two 120-ohm terminating resistors wired in parallel. 120 ohms in parallel with 120 ohms equals 60 ohms, indicating the network integrity is good.', 'Network Communications', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'An open circuit in one of the CAN lines', FALSE),
((SELECT MAX(id) FROM questions), 'A short to ground in the CAN bus', FALSE),
((SELECT MAX(id) FROM questions), 'A normal, healthy CAN network', TRUE),
((SELECT MAX(id) FROM questions), 'A missing terminating resistor', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'An A/C system cools well for the first 15 minutes of driving, but then airflow from the vents drops significantly and the air turns warm. What is the most likely cause?', 'A faulty thermostatic switch or a low refrigerant charge can cause the evaporator core to freeze over with ice, blocking airflow through the vents.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A slipping compressor clutch', FALSE),
((SELECT MAX(id) FROM questions), 'The evaporator core is freezing up', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty blend door actuator', FALSE),
((SELECT MAX(id) FROM questions), 'A clogged cabin air filter', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'Technician A says a restricted condenser airflow can cause high high-side pressures. Technician B says an overcharge of refrigerant can cause high high-side pressures. Who is right?', 'Both restricted airflow across the condenser (bugs, dirt, bad fan) and an overcharge of refrigerant will cause the high-side pressure to rise above normal specifications.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A8: Engine Performance
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'An engine stalls immediately after starting and idles very rough. A scan tool shows the EGR valve position is at 40% at idle. What is the most likely cause?', 'The EGR valve should be fully closed at idle. If it is stuck open (40%), exhaust gases will flood the intake manifold, causing a rough idle or stalling.', 'Emission Control Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A clogged catalytic converter', FALSE),
((SELECT MAX(id) FROM questions), 'A stuck open EGR valve', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty idle air control (IAC) valve', FALSE),
((SELECT MAX(id) FROM questions), 'A vacuum leak', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A vehicle has a long crank time before starting and blows black smoke when it finally starts. A fuel pressure gauge shows pressure drops rapidly to zero as soon as the engine is turned off. What is the most likely cause?', 'A leaking fuel pressure regulator or a leaking fuel injector allows fuel to drain into the intake manifold when the engine is off, causing a loss of rest pressure and a rich condition on startup.', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A clogged fuel filter', FALSE),
((SELECT MAX(id) FROM questions), 'A weak fuel pump', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking fuel pressure regulator', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty mass air flow sensor', FALSE);

-- ==========================================
-- A1: Engine Repair
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Technician A says a valve clearance that is set too tight can cause a burned exhaust valve. Technician B says a valve clearance that is set too loose will cause valve clatter. Who is right?', 'If valve clearance is too tight, the valve may not fully seat, preventing it from transferring heat to the cylinder head, leading to a burned valve. Loose clearance causes excessive noise (clatter).', 'Cylinder Head Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Engine oil appears milky and brown. What is the most likely cause?', 'Milky engine oil is a classic sign that engine coolant is mixing with the oil, typically due to a blown head gasket, cracked block, or leaking intake manifold gasket.', 'Lubrication Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Excessive fuel in the oil', FALSE),
((SELECT MAX(id) FROM questions), 'Coolant mixing with the oil', TRUE),
((SELECT MAX(id) FROM questions), 'Overdue oil change', FALSE),
((SELECT MAX(id) FROM questions), 'Using the wrong viscosity oil', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'In a hydraulically controlled automatic transmission, governor pressure increases proportionally with:', 'Governor pressure is generated by the governor assembly, which is driven by the output shaft. Therefore, governor pressure increases as vehicle speed increases.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Engine RPM', FALSE),
((SELECT MAX(id) FROM questions), 'Throttle position', FALSE),
((SELECT MAX(id) FROM questions), 'Vehicle speed', TRUE),
((SELECT MAX(id) FROM questions), 'Torque converter slip', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A vehicle will not crank in Park or Neutral. Technician A says a misadjusted Transmission Range (TR) sensor could be the cause. Technician B says a faulty starter relay could be the cause. Who is right?', 'Both a misadjusted TR sensor (neutral safety switch) and a faulty starter relay can prevent the starter circuit from engaging.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'When performing a transmission fluid pressure test, the pressure is low in all forward gears but normal in reverse. What is the most likely cause?', 'If pressure is low only in forward gears, the issue is isolated to the forward clutch circuit, such as a leaking forward clutch piston seal.', 'Hydraulic System', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty oil pump', FALSE),
((SELECT MAX(id) FROM questions), 'A clogged transmission filter', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking forward clutch seal', TRUE),
((SELECT MAX(id) FROM questions), 'A stuck pressure regulator valve', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A customer complains of a severe shudder when releasing the clutch pedal to take off from a stop. What is the most likely cause?', 'Clutch chatter or shudder during engagement is typically caused by oil or grease on the clutch disc friction material, or a warped flywheel/pressure plate.', 'Clutch Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn release bearing', FALSE),
((SELECT MAX(id) FROM questions), 'Oil contamination on the clutch disc', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty clutch master cylinder', FALSE),
((SELECT MAX(id) FROM questions), 'Air in the hydraulic clutch lines', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'To prevent driveline vibration on a conventional rear-wheel-drive vehicle, the operating angles of the front and rear U-joints must be:', 'For smooth power transmission, the operating angles of the U-joints at both ends of the driveshaft must be equal and opposite (usually within 1 degree of each other).', 'Driveshaft Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Exactly zero degrees', FALSE),
((SELECT MAX(id) FROM questions), 'Equal and opposite', TRUE),
((SELECT MAX(id) FROM questions), 'Greater than 5 degrees', FALSE),
((SELECT MAX(id) FROM questions), 'Different by at least 2 degrees', FALSE);

-- ==========================================
-- A4: Suspension & Steering
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle exhibits a severe steering wheel shimmy that only occurs at highway speeds (55-65 mph). What is the most likely cause?', 'A shimmy or vibration that occurs only at specific highway speeds is almost always caused by a dynamic imbalance of the front tire and wheel assemblies.', 'Wheel and Tire Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn tie rod ends', FALSE),
((SELECT MAX(id) FROM questions), 'Dynamic wheel imbalance', TRUE),
((SELECT MAX(id) FROM questions), 'Incorrect caster setting', FALSE),
((SELECT MAX(id) FROM questions), 'A loose steering gear', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Power steering fluid is found leaking from the bellows boots on a rack and pinion steering gear. What is the required repair?', 'The bellows boots only protect the inner tie rods from dirt. If power steering fluid is inside the boots, the inner rack seals have failed, requiring replacement or rebuilding of the rack and pinion assembly.', 'Steering Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Replace the bellows boots and clamps', FALSE),
((SELECT MAX(id) FROM questions), 'Replace the inner tie rod ends', FALSE),
((SELECT MAX(id) FROM questions), 'Replace or rebuild the rack and pinion assembly', TRUE),
((SELECT MAX(id) FROM questions), 'Flush the power steering fluid', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Technician A says adjusting the torsion bars on a vehicle will change the ride height. Technician B says adjusting the torsion bars will change the camber and caster angles. Who is right?', 'Adjusting the torsion bars changes the ride height. Because the control arms move in an arc, changing the ride height will also alter the camber and caster angles.', 'Suspension Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A5: Brakes
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A customer complains of a rhythmic pulsation in the brake pedal when stopping from highway speeds. What is the most likely cause?', 'Brake pedal pulsation is caused by thickness variation (parallelism) in the brake rotor, which forces the caliper piston and brake fluid back up the lines, pushing against the driver''s foot.', 'Brake Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Air in the hydraulic system', FALSE),
((SELECT MAX(id) FROM questions), 'Rotor thickness variation', TRUE),
((SELECT MAX(id) FROM questions), 'Worn brake pad friction material', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty ABS wheel speed sensor', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the purpose of the check valve located in the vacuum hose leading to the power brake booster?', 'The check valve traps vacuum inside the booster so the driver still has power assist for one or two stops if the engine stalls.', 'Power Assist Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To prevent brake fluid from entering the engine', FALSE),
((SELECT MAX(id) FROM questions), 'To hold vacuum in the booster if the engine stalls', TRUE),
((SELECT MAX(id) FROM questions), 'To regulate the amount of vacuum entering the booster', FALSE),
((SELECT MAX(id) FROM questions), 'To vent excess pressure to the atmosphere', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When performing a parasitic draw test using a digital multimeter, the meter should be connected in:', 'To measure current (amperage) draw, the multimeter must become part of the circuit, which means it must be connected in series between the negative battery cable and the negative battery post.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Parallel across the battery terminals', FALSE),
((SELECT MAX(id) FROM questions), 'Series between the negative battery cable and the negative post', TRUE),
((SELECT MAX(id) FROM questions), 'Parallel across the suspected component', FALSE),
((SELECT MAX(id) FROM questions), 'Series between the positive battery cable and the alternator', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A voltage drop test is performed across a good, properly functioning fuse in an active circuit. What should the multimeter read?', 'A good fuse has virtually zero resistance. Therefore, when current flows through it, there should be no measurable voltage drop (reading should be 0.0V or very close to it).', 'Electrical Fundamentals', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), '12.6 volts', FALSE),
((SELECT MAX(id) FROM questions), 'Source voltage', FALSE),
((SELECT MAX(id) FROM questions), '0.0 volts', TRUE),
((SELECT MAX(id) FROM questions), '5.0 volts', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'Technician A says a full-field test on an alternator bypasses the voltage regulator to check maximum alternator output. Technician B says a full-field test should only be performed for a few seconds. Who is right?', 'Bypassing the regulator (full-fielding) forces the alternator to produce maximum output. This should only be done briefly to avoid damaging the alternator or vehicle electronics.', 'Charging Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'An A/C compressor clutch will not engage. A technician jumps the low-pressure cutoff switch connector, and the compressor engages. What is the most likely cause?', 'The low-pressure switch opens the compressor clutch circuit if the refrigerant level drops too low, protecting the compressor from damage due to lack of lubrication.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty compressor clutch coil', FALSE),
((SELECT MAX(id) FROM questions), 'Low refrigerant charge', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty A/C relay', FALSE),
((SELECT MAX(id) FROM questions), 'A clogged orifice tube', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A customer complains of a sweet smell in the cabin and a greasy film on the inside of the windshield when the defroster is turned on. What is the most likely cause?', 'A leaking heater core allows engine coolant (which smells sweet and contains glycol) to vaporize into the HVAC case and blow onto the windshield, leaving a greasy film.', 'Heating System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A leaking A/C evaporator', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking heater core', TRUE),
((SELECT MAX(id) FROM questions), 'A clogged cabin air filter', FALSE),
((SELECT MAX(id) FROM questions), 'An exhaust leak near the cowl', FALSE);

-- ==========================================
-- A8: Engine Performance
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A scan tool displays a P0420 code (Catalyst System Efficiency Below Threshold). Which sensor does the PCM use to determine this?', 'The PCM compares the switching rate of the upstream O2 sensor to the downstream O2 sensor. If the downstream sensor switches as rapidly as the upstream sensor, the catalyst is no longer storing oxygen effectively.', 'Emission Control Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Mass Air Flow (MAF) sensor', FALSE),
((SELECT MAX(id) FROM questions), 'Upstream Oxygen (O2) sensor only', FALSE),
((SELECT MAX(id) FROM questions), 'Downstream Oxygen (O2) sensor', TRUE),
((SELECT MAX(id) FROM questions), 'Engine Coolant Temperature (ECT) sensor', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A scan tool shows a Long Term Fuel Trim (LTFT) of +18%. What does this indicate?', 'A positive fuel trim means the PCM is adding fuel to compensate for a lean condition (too much air or not enough fuel).', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The engine is running rich, and the PCM is subtracting fuel', FALSE),
((SELECT MAX(id) FROM questions), 'The engine is running lean, and the PCM is adding fuel', TRUE),
((SELECT MAX(id) FROM questions), 'The fuel system is operating normally', FALSE),
((SELECT MAX(id) FROM questions), 'The oxygen sensor is stuck rich', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'When testing an ignition coil with an ohmmeter, the primary winding resistance should typically be:', 'The primary winding of an ignition coil consists of a few turns of heavy wire, resulting in very low resistance (usually 0.5 to 2.0 ohms). The secondary winding has high resistance (thousands of ohms).', 'Ignition System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Very high (5,000 to 10,000 ohms)', FALSE),
((SELECT MAX(id) FROM questions), 'Very low (0.5 to 2.0 ohms)', TRUE),
((SELECT MAX(id) FROM questions), 'Infinite (OL)', FALSE),
((SELECT MAX(id) FROM questions), 'Zero ohms', FALSE);

-- ==========================================
-- A1: Engine Repair
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When using Plastigage to measure main bearing clearance, the Plastigage is crushed wider than the specification allows. What does this indicate?', 'Plastigage spreads out as it is crushed. A wider crush mark means the gap was smaller, indicating the bearing clearance is tighter than specified.', 'Engine Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The clearance is too loose', FALSE),
((SELECT MAX(id) FROM questions), 'The clearance is too tight', TRUE),
((SELECT MAX(id) FROM questions), 'The crankshaft is bent', FALSE),
((SELECT MAX(id) FROM questions), 'The bearing is perfectly within spec', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A stretched timing chain will have what effect on engine operation?', 'A stretched timing chain causes the camshaft to lag behind the crankshaft, resulting in retarded valve timing and a loss of low-end engine power.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Advanced valve timing', FALSE),
((SELECT MAX(id) FROM questions), 'Retarded valve timing', TRUE),
((SELECT MAX(id) FROM questions), 'Increased oil pressure', FALSE),
((SELECT MAX(id) FROM questions), 'Advanced ignition timing', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A vehicle has very poor acceleration from a stop, but performs normally at highway speeds. The transmission fluid is full and in good condition. What is the most likely cause?', 'If the torque converter stator one-way clutch fails and freewheels in both directions, torque multiplication is lost, resulting in very sluggish acceleration from a stop.', 'Torque Converter Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A slipping forward clutch', FALSE),
((SELECT MAX(id) FROM questions), 'A stator one-way clutch that freewheels in both directions', TRUE),
((SELECT MAX(id) FROM questions), 'A stator one-way clutch that is locked in both directions', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty torque converter clutch (TCC) solenoid', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'When performing a transmission cooler flow test, the fluid flow is well below specifications. Technician A says a restricted transmission cooler could be the cause. Technician B says a faulty transmission oil pump could be the cause. Who is right?', 'Both a restricted cooler (clogged lines/radiator) and a weak transmission oil pump (low volume) can cause low cooler flow.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'Which component is responsible for holding a planetary gearset member stationary?', 'Bands and multiple-disc clutches are the friction devices used to hold a planetary gear member stationary to the transmission case.', 'Transmission Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The torque converter', FALSE),
((SELECT MAX(id) FROM questions), 'A transmission band or clutch', TRUE),
((SELECT MAX(id) FROM questions), 'The governor assembly', FALSE),
((SELECT MAX(id) FROM questions), 'The valve body', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'What is the primary purpose of the synchronizer blocking ring in a manual transmission?', 'The blocking ring acts as a cone clutch, using friction to match the speed of the gear to the speed of the synchronizer sleeve before allowing the teeth to engage, preventing gear clash.', 'Transmission Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To lock the main shaft to the countershaft', FALSE),
((SELECT MAX(id) FROM questions), 'To match the speed of the gear and the synchronizer sleeve', TRUE),
((SELECT MAX(id) FROM questions), 'To prevent the transmission from popping out of gear', FALSE),
((SELECT MAX(id) FROM questions), 'To lubricate the gear bearings', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A manual transaxle has a gear ratio of 0.85:1 in 5th gear. This is an example of:', 'Any gear ratio where the first number is less than 1 (e.g., 0.85:1) means the output shaft is turning faster than the input shaft, which is an overdrive ratio.', 'Drivetrain Theory', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Gear reduction', FALSE),
((SELECT MAX(id) FROM questions), 'Direct drive', FALSE),
((SELECT MAX(id) FROM questions), 'Overdrive', TRUE),
((SELECT MAX(id) FROM questions), 'Reverse', FALSE);

-- ==========================================
-- A4: Suspension & Steering
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle has a power steering pressure gauge installed. The pressure is normal at idle, but when the steering wheel is turned to the full lock position, the pressure does not rise to the maximum specification. What is the most likely cause?', 'When the steering is at full lock, the pump should produce maximum pressure until the pressure relief valve opens. If it doesn''t, the pump is weak or the relief valve is stuck open.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted high-pressure hose', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty power steering pump', TRUE),
((SELECT MAX(id) FROM questions), 'Air in the power steering fluid', FALSE),
((SELECT MAX(id) FROM questions), 'A loose power steering belt', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Technician A says a load-carrying ball joint should be checked for wear with the suspension unloaded. Technician B says a follower ball joint should be checked with the suspension loaded. Who is right?', 'Neither is right. A load-carrying ball joint must be unloaded (weight taken off it) to check for play. A follower ball joint is checked with the suspension loaded.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', TRUE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Which alignment angle is defined as the inward or outward tilt of the top of the tire when viewed from the front of the vehicle?', 'Camber is the inward (negative) or outward (positive) tilt of the top of the tire when viewed from the front.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Caster', FALSE),
((SELECT MAX(id) FROM questions), 'Camber', TRUE),
((SELECT MAX(id) FROM questions), 'Toe', FALSE),
((SELECT MAX(id) FROM questions), 'Thrust angle', FALSE);

-- ==========================================
-- A5: Brakes
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A customer complains that the brake pedal slowly sinks to the floor when held at a stoplight. There are no external fluid leaks. What is the most likely cause?', 'An internal leak in the master cylinder (fluid bypassing the primary piston cup) will cause the pedal to slowly sink to the floor under steady pressure without any external fluid loss.', 'Hydraulic System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Air in the brake lines', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty brake booster', FALSE),
((SELECT MAX(id) FROM questions), 'An internal master cylinder leak', TRUE),
((SELECT MAX(id) FROM questions), 'Worn brake pads', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When testing a passive (variable reluctance) ABS wheel speed sensor with a multimeter while spinning the wheel, the meter should be set to read:', 'A passive wheel speed sensor generates its own alternating current (AC) voltage as the toothed tone ring spins past its magnetic field.', 'Electronic Brake Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'DC Volts', FALSE),
((SELECT MAX(id) FROM questions), 'AC Volts', TRUE),
((SELECT MAX(id) FROM questions), 'Ohms', FALSE),
((SELECT MAX(id) FROM questions), 'DC Amps', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Brake fluid is hygroscopic, meaning it absorbs moisture from the air. How does this affect the brake fluid?', 'Absorbed moisture significantly lowers the boiling point of the brake fluid, which can lead to fluid boil and brake fade under heavy braking conditions.', 'Brake Fluid', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'It raises the boiling point', FALSE),
((SELECT MAX(id) FROM questions), 'It lowers the boiling point', TRUE),
((SELECT MAX(id) FROM questions), 'It increases the fluid''s viscosity', FALSE),
((SELECT MAX(id) FROM questions), 'It prevents internal corrosion', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'On a standard 5-pin ISO relay, which terminal is the "Normally Closed" (NC) contact?', 'Terminal 87a is the normally closed contact. It has continuity with terminal 30 when the relay coil is de-energized.', 'Electrical Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Terminal 87', FALSE),
((SELECT MAX(id) FROM questions), 'Terminal 85', FALSE),
((SELECT MAX(id) FROM questions), 'Terminal 87a', TRUE),
((SELECT MAX(id) FROM questions), 'Terminal 86', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When performing a battery load test, the carbon pile should be adjusted to draw how many amps?', 'A standard battery load test requires drawing one-half (1/2) of the battery''s Cold Cranking Amps (CCA) rating for 15 seconds. The voltage must remain above 9.6V (at 70°F).', 'Battery Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Equal to the CCA rating', FALSE),
((SELECT MAX(id) FROM questions), 'Twice the CCA rating', FALSE),
((SELECT MAX(id) FROM questions), 'One-half the CCA rating', TRUE),
((SELECT MAX(id) FROM questions), 'A flat 100 amps for all batteries', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'Technician A says an ohmmeter must be used on a live, powered circuit. Technician B says an ohmmeter provides its own voltage to measure resistance. Who is right?', 'An ohmmeter uses its own internal battery to send a small current through a component to measure resistance. It must NEVER be used on a powered circuit, or the meter could be damaged.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', TRUE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'In an A/C system equipped with a Thermostatic Expansion Valve (TXV), where is the sensing bulb located?', 'The TXV sensing bulb is clamped to the evaporator outlet tailpipe. It senses the temperature of the refrigerant leaving the evaporator to regulate the TXV opening.', 'A/C System Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'On the condenser inlet', FALSE),
((SELECT MAX(id) FROM questions), 'On the evaporator inlet', FALSE),
((SELECT MAX(id) FROM questions), 'On the evaporator outlet', TRUE),
((SELECT MAX(id) FROM questions), 'Inside the receiver-drier', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'When using an electronic leak detector to check for A/C refrigerant leaks, the probe should be moved:', 'Refrigerant is heavier than air, so it tends to sink. The probe should be moved slowly (about 1 inch per second) below the components being tested.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Rapidly above the components', FALSE),
((SELECT MAX(id) FROM questions), 'Slowly above the components', FALSE),
((SELECT MAX(id) FROM questions), 'Rapidly below the components', FALSE),
((SELECT MAX(id) FROM questions), 'Slowly below the components', TRUE);

-- ==========================================
-- A8: Engine Performance
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'As engine intake manifold vacuum decreases (such as during heavy acceleration), the voltage output of an analog Manifold Absolute Pressure (MAP) sensor will:', 'As vacuum decreases (absolute pressure increases), the MAP sensor voltage output increases to tell the PCM the engine is under a heavy load.', 'Engine Sensors', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Decrease', FALSE),
((SELECT MAX(id) FROM questions), 'Increase', TRUE),
((SELECT MAX(id) FROM questions), 'Remain constant', FALSE),
((SELECT MAX(id) FROM questions), 'Drop to zero', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'When viewing an ignition secondary waveform on an oscilloscope, a shorter-than-normal spark burn time (spark line) indicates:', 'A short burn time indicates high resistance in the secondary circuit (like a wide spark plug gap or bad wire) or a lean fuel mixture, which requires more voltage to fire, leaving less energy for the burn duration.', 'Ignition System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A rich air/fuel mixture', FALSE),
((SELECT MAX(id) FROM questions), 'A fouled spark plug', FALSE),
((SELECT MAX(id) FROM questions), 'High secondary circuit resistance or a lean mixture', TRUE),
((SELECT MAX(id) FROM questions), 'A shorted ignition coil primary winding', FALSE);

-- ==========================================
-- A1: Engine Repair
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A vehicle has engine oil in the coolant reservoir, but there is no coolant in the engine oil pan. What is the most likely cause?', 'Because engine oil pressure is higher than cooling system pressure, a leak in an internal engine oil cooler (radiator or block mounted) will push oil into the coolant without pulling coolant into the oil.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A blown head gasket', FALSE),
((SELECT MAX(id) FROM questions), 'A cracked engine block', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking engine oil cooler', TRUE),
((SELECT MAX(id) FROM questions), 'A warped cylinder head', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A vacuum gauge connected to the intake manifold fluctuates rapidly between 14 and 19 in. Hg at idle. What does this indicate?', 'Rapid fluctuation of the vacuum gauge needle at idle is a classic indicator of worn valve guides, which allow the valves to vibrate as they seat.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn piston rings', FALSE),
((SELECT MAX(id) FROM questions), 'Worn valve guides', TRUE),
((SELECT MAX(id) FROM questions), 'A restricted exhaust system', FALSE),
((SELECT MAX(id) FROM questions), 'A steady intake manifold leak', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'Which sensor input has the greatest influence on Electronic Pressure Control (EPC) solenoid operation for determining transmission line pressure?', 'The Throttle Position Sensor (TPS) or Manifold Absolute Pressure (MAP) sensor indicates engine load. The PCM uses this load data to increase line pressure via the EPC solenoid to prevent clutch slippage during heavy acceleration.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Vehicle Speed Sensor (VSS)', FALSE),
((SELECT MAX(id) FROM questions), 'Engine Coolant Temperature (ECT) sensor', FALSE),
((SELECT MAX(id) FROM questions), 'Throttle Position Sensor (TPS) or MAP sensor', TRUE),
((SELECT MAX(id) FROM questions), 'Transmission Fluid Temperature (TFT) sensor', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'When checking the fluid level on most automatic transmissions equipped with a dipstick, the vehicle should be:', 'Most manufacturers require the transmission fluid to be checked with the engine running, the transmission in Park, and the fluid at normal operating temperature.', 'Transmission Maintenance', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Engine off, in Park, fluid cold', FALSE),
((SELECT MAX(id) FROM questions), 'Engine running, in Park, fluid hot', TRUE),
((SELECT MAX(id) FROM questions), 'Engine running, in Drive, fluid hot', FALSE),
((SELECT MAX(id) FROM questions), 'Engine off, in Neutral, fluid hot', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'During a transmission rebuild, a one-way clutch (sprag) is installed backwards. What is the most likely result?', 'If a one-way clutch is installed backwards, it will freewheel when it is supposed to lock, resulting in a complete loss of drive in the gear(s) that rely on that clutch.', 'Transmission Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Harsh shifting in all gears', FALSE),
((SELECT MAX(id) FROM questions), 'No movement in a specific gear range', TRUE),
((SELECT MAX(id) FROM questions), 'Delayed engagement into Reverse only', FALSE),
((SELECT MAX(id) FROM questions), 'Transmission fluid overheating', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A front-wheel-drive vehicle makes a loud clicking or popping noise when turning tightly at low speeds. What is the most likely cause?', 'A clicking noise while turning is the classic symptom of a worn or damaged outer Constant Velocity (CV) joint.', 'Drivetrain Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn inner CV joint', FALSE),
((SELECT MAX(id) FROM questions), 'A worn outer CV joint', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty wheel bearing', FALSE),
((SELECT MAX(id) FROM questions), 'Low transaxle fluid', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'When bleeding a hydraulic clutch system, Technician A says to pump the pedal rapidly to build pressure. Technician B says a vacuum bleeder can be used at the slave cylinder. Who is right?', 'Pumping the pedal rapidly can aerate the fluid (create tiny bubbles). A vacuum bleeder, pressure bleeder, or gravity bleeding are the preferred methods for hydraulic clutches.', 'Clutch Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', TRUE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A4: Suspension & Steering
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle equipped with an electronic air suspension system has an air compressor that runs constantly while driving. What is the most likely cause?', 'If the compressor runs constantly, it is trying to compensate for a continuous loss of air pressure, usually caused by a leak in an air spring or air line.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty ride height sensor', FALSE),
((SELECT MAX(id) FROM questions), 'A leak in an air spring or line', TRUE),
((SELECT MAX(id) FROM questions), 'A blown compressor fuse', FALSE),
((SELECT MAX(id) FROM questions), 'A shorted suspension control module', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Which of the following describes "Scrub Radius"?', 'Scrub radius is the distance at the road surface between the tire centerline and the steering axis inclination (SAI) line extended downward.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The distance between the front and rear wheels', FALSE),
((SELECT MAX(id) FROM questions), 'The angle of the steering knuckle', FALSE),
((SELECT MAX(id) FROM questions), 'The distance between the tire centerline and the SAI line at the road surface', TRUE),
((SELECT MAX(id) FROM questions), 'The amount of toe change during suspension jounce', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle wanders on a straight, level road and requires constant steering corrections. The alignment angles are within specification. What is the most likely cause?', 'Wandering is often caused by loose or worn steering linkage components (like tie rods or a worn steering gear) that allow the wheels to shift independently of the steering wheel.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Excessive positive caster', FALSE),
((SELECT MAX(id) FROM questions), 'Worn steering linkage or steering gear', TRUE),
((SELECT MAX(id) FROM questions), 'Unequal camber side-to-side', FALSE),
((SELECT MAX(id) FROM questions), 'A binding upper strut mount', FALSE);

-- ==========================================
-- A5: Brakes
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Why must a new master cylinder be bench bled before installation on the vehicle?', 'A master cylinder must be bench bled to remove air trapped inside its bore. If installed dry, it is nearly impossible to push the trapped air all the way down through the vehicle''s brake lines.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To lubricate the piston seals before use', FALSE),
((SELECT MAX(id) FROM questions), 'To remove trapped air from the master cylinder bore', TRUE),
((SELECT MAX(id) FROM questions), 'To test the proportioning valve', FALSE),
((SELECT MAX(id) FROM questions), 'To prevent ABS module damage', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A customer complains of a high-pitched squeal from the front brakes that goes away when the brake pedal is depressed. What is the most likely cause?', 'Mechanical wear indicators (squealers) are designed to rub against the rotor and make a high-pitched noise when the pads are worn thin. The noise often stops when the brakes are applied and the pad clamps tightly to the rotor.', 'Brake Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn brake pad wear indicators contacting the rotor', TRUE),
((SELECT MAX(id) FROM questions), 'A warped brake rotor', FALSE),
((SELECT MAX(id) FROM questions), 'Air in the brake lines', FALSE),
((SELECT MAX(id) FROM questions), 'A seized caliper slide pin', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Technician A says an excessive gap between a passive ABS wheel speed sensor and the tone ring will cause a weak AC voltage signal. Technician B says a cracked tone ring can cause false ABS activation at low speeds. Who is right?', 'Both are correct. A large gap weakens the magnetic induction (low AC voltage), and a cracked tone ring creates an irregular signal that the ABS module interprets as wheel lockup at low speeds.', 'Electronic Brake Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When reading automotive wire sizes in the American Wire Gauge (AWG) system, which of the following is true?', 'In the AWG system, the smaller the gauge number, the larger the physical diameter of the wire (e.g., 10 AWG is much thicker than 18 AWG).', 'Electrical Fundamentals', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A larger gauge number indicates a larger wire diameter', FALSE),
((SELECT MAX(id) FROM questions), 'A smaller gauge number indicates a larger wire diameter', TRUE),
((SELECT MAX(id) FROM questions), 'Wire gauge numbers only apply to battery cables', FALSE),
((SELECT MAX(id) FROM questions), 'All automotive wiring uses 12 AWG', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A starter current draw test is being performed. The engine cranks at normal speed, but the current draw is significantly higher than specification. What is the most likely cause?', 'If the starter draws too much current but cranks normally, the starter motor itself is likely failing internally (e.g., shorted armature or field coils). High mechanical engine resistance would cause slow cranking.', 'Starting System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'High resistance in the positive battery cable', FALSE),
((SELECT MAX(id) FROM questions), 'A weak battery', FALSE),
((SELECT MAX(id) FROM questions), 'An internal short in the starter motor', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty ignition switch', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'Technician A says a relay is used to control a high-current circuit with a low-current switch. Technician B says a relay contains an electromagnetic coil. Who is right?', 'Both are correct. A relay uses a low-current electromagnetic coil to pull a set of contacts closed, which then completes a high-current circuit.', 'Electrical Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'What is the primary purpose of the evaporator temperature sensor (or thermistor) in an A/C system?', 'The evaporator temperature sensor monitors the core temperature and cycles the compressor off if the temperature drops too close to freezing (32°F / 0°C) to prevent ice buildup.', 'A/C System Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To control the blend door actuator', FALSE),
((SELECT MAX(id) FROM questions), 'To prevent the evaporator core from freezing', TRUE),
((SELECT MAX(id) FROM questions), 'To regulate condenser fan speed', FALSE),
((SELECT MAX(id) FROM questions), 'To measure ambient outside air temperature', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'When recovering refrigerant from an A/C system, why is it important to measure the amount of oil removed during the process?', 'Refrigerant oil circulates with the refrigerant. Any oil removed during recovery must be measured and replaced with the exact same amount of new oil to prevent compressor failure.', 'A/C System Service', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To determine if the compressor is failing', FALSE),
((SELECT MAX(id) FROM questions), 'To know how much new oil to add back into the system', TRUE),
((SELECT MAX(id) FROM questions), 'To calculate the exact refrigerant charge', FALSE),
((SELECT MAX(id) FROM questions), 'To check for coolant cross-contamination', FALSE);

-- ==========================================
-- A8: Engine Performance
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A technician is testing a fuel injector with a digital multimeter. The resistance reading is 1.2 ohms, but the specification is 12 to 16 ohms. What does this indicate?', 'A resistance reading significantly lower than specification indicates that the coil windings inside the fuel injector are shorted together.', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The injector is internally shorted', TRUE),
((SELECT MAX(id) FROM questions), 'The injector has an open circuit', FALSE),
((SELECT MAX(id) FROM questions), 'The injector is clogged with debris', FALSE),
((SELECT MAX(id) FROM questions), 'The injector is functioning normally', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'What is the purpose of the heater circuit inside a modern Oxygen (O2) sensor?', 'O2 sensors must reach approximately 600°F (315°C) to generate a voltage signal. The internal heater brings the sensor to operating temperature quickly to reduce cold-start emissions.', 'Emission Control Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To burn off carbon deposits', FALSE),
((SELECT MAX(id) FROM questions), 'To bring the sensor to operating temperature quickly', TRUE),
((SELECT MAX(id) FROM questions), 'To measure exhaust gas temperature', FALSE),
((SELECT MAX(id) FROM questions), 'To cool the sensor during heavy engine load', FALSE);

-- ==========================================
-- A1: Engine Repair
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When measuring piston ring end gap, the ring should be pushed into the cylinder bore using an inverted piston. Why is this done?', 'Using an inverted piston ensures the piston ring is perfectly square (perpendicular) to the cylinder walls, which is required for an accurate end gap measurement.', 'Engine Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To prevent scratching the cylinder wall', FALSE),
((SELECT MAX(id) FROM questions), 'To ensure the ring is square in the bore', TRUE),
((SELECT MAX(id) FROM questions), 'To measure the piston-to-wall clearance simultaneously', FALSE),
((SELECT MAX(id) FROM questions), 'To compress the ring to its minimum diameter', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A technician is checking valve springs. Which of the following measurements requires the use of a machinist square?', 'A machinist square and a feeler gauge are used to check valve springs for squareness (freestanding straightness). If a spring is out of square, it can cause side-loading on the valve stem.', 'Cylinder Head Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Valve spring installed height', FALSE),
((SELECT MAX(id) FROM questions), 'Valve spring tension', FALSE),
((SELECT MAX(id) FROM questions), 'Valve spring squareness', TRUE),
((SELECT MAX(id) FROM questions), 'Valve spring free length', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'What is the primary function of an accumulator in an automatic transmission?', 'An accumulator acts as a shock absorber in the hydraulic system. It temporarily absorbs some of the fluid pressure during a shift to cushion the engagement of a clutch or band.', 'Hydraulic System', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To increase maximum line pressure', FALSE),
((SELECT MAX(id) FROM questions), 'To cushion shift engagement', TRUE),
((SELECT MAX(id) FROM questions), 'To direct fluid to the torque converter', FALSE),
((SELECT MAX(id) FROM questions), 'To filter debris from the transmission fluid', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'In a simple planetary gearset, if the ring gear is the input, the sun gear is held stationary, and the planetary carrier is the output, what is the result?', 'Driving the ring gear while holding the sun gear forces the carrier to walk around the sun gear, resulting in a forward gear reduction (though less of a reduction than driving the sun gear).', 'Planetary Gearsets', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Reverse', FALSE),
((SELECT MAX(id) FROM questions), 'Overdrive', FALSE),
((SELECT MAX(id) FROM questions), 'Forward gear reduction', TRUE),
((SELECT MAX(id) FROM questions), 'Direct drive (1:1)', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A vehicle with an electronically controlled automatic transmission is stuck in 3rd gear and will not upshift or downshift. The check engine light is on. What is the most likely cause?', 'When an electronic transmission detects a severe electrical fault (like a loss of power to the solenoids), it defaults to a mechanical "limp-in" mode, which is typically 2nd or 3rd gear.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A broken planetary gear', FALSE),
((SELECT MAX(id) FROM questions), 'The transmission is in fail-safe (limp-in) mode', TRUE),
((SELECT MAX(id) FROM questions), 'A stuck open torque converter clutch', FALSE),
((SELECT MAX(id) FROM questions), 'Low transmission fluid', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A vehicle equipped with a hydraulic clutch system has a clutch pedal that feels spongy and engages very close to the floor. What is the most likely cause?', 'A spongy pedal in any hydraulic system (brakes or clutch) is almost always caused by air trapped in the hydraulic lines or cylinders.', 'Clutch Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn clutch disc', FALSE),
((SELECT MAX(id) FROM questions), 'Air in the hydraulic clutch system', TRUE),
((SELECT MAX(id) FROM questions), 'A binding release bearing', FALSE),
((SELECT MAX(id) FROM questions), 'A warped pressure plate', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'In an All-Wheel Drive (AWD) system, what component is typically used to allow for speed differences between the front and rear axles during cornering?', 'A center differential (or a viscous coupling/transfer clutch) allows the front and rear driveshafts to turn at different speeds, preventing driveline bind during turns.', 'Drivetrain Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A locking hub', FALSE),
((SELECT MAX(id) FROM questions), 'A center differential or viscous coupling', TRUE),
((SELECT MAX(id) FROM questions), 'A synchronizer assembly', FALSE),
((SELECT MAX(id) FROM questions), 'A dual-mass flywheel', FALSE);

-- ==========================================
-- A4: Suspension & Steering
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'When diagnosing a parallelogram steering linkage, Technician A says the idler arm should be checked for up-and-down movement. Technician B says the pitman arm connects the steering gear to the center link. Who is right?', 'Both are correct. The idler arm supports the passenger side of the center link and is checked for vertical play. The pitman arm transfers motion from the steering gear to the center link.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Which alignment angle is calculated by adding Camber and Steering Axis Inclination (SAI) together?', 'Included Angle is the sum of Camber and SAI. It is a diagnostic angle used to determine if a steering knuckle or MacPherson strut is bent.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Caster', FALSE),
((SELECT MAX(id) FROM questions), 'Included Angle', TRUE),
((SELECT MAX(id) FROM questions), 'Thrust Angle', FALSE),
((SELECT MAX(id) FROM questions), 'Toe-out on turns (Turning Radius)', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle leans to the right side when parked on a level surface. What is the most likely cause?', 'Vehicle ride height (and leaning) is controlled by the springs. A sagging or broken right-side spring will cause the vehicle to lean to that side.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A blown right-side shock absorber', FALSE),
((SELECT MAX(id) FROM questions), 'A sagging right-side spring', TRUE),
((SELECT MAX(id) FROM questions), 'A worn right-side lower ball joint', FALSE),
((SELECT MAX(id) FROM questions), 'Incorrect camber on the right side', FALSE);

-- ==========================================
-- A5: Brakes
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When replacing rear drum brake shoes, the primary shoe is typically installed facing the:', 'The primary shoe (which usually has a shorter friction lining) is installed facing the front of the vehicle. The secondary shoe faces the rear and does most of the braking work due to servo action.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Front of the vehicle', TRUE),
((SELECT MAX(id) FROM questions), 'Rear of the vehicle', FALSE),
((SELECT MAX(id) FROM questions), 'Top of the backing plate', FALSE),
((SELECT MAX(id) FROM questions), 'Bottom of the backing plate', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle with a vacuum power brake booster has a hard pedal. The technician removes the vacuum hose from the booster and hears a loud "whoosh" of air entering the booster. What does this indicate?', 'The "whoosh" of air means the booster was holding a vacuum, which indicates the check valve and the booster diaphragm are sealing properly. The hard pedal is likely caused by a mechanical issue or a lack of vacuum supply while running.', 'Power Assist Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The booster diaphragm is ruptured', FALSE),
((SELECT MAX(id) FROM questions), 'The booster check valve is leaking', FALSE),
((SELECT MAX(id) FROM questions), 'The booster is holding vacuum normally', TRUE),
((SELECT MAX(id) FROM questions), 'The master cylinder is leaking internally', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When bleeding a brake system equipped with ABS, what additional step is often required compared to a non-ABS system?', 'Many ABS systems require a scan tool to cycle the ABS pump and valves to purge trapped air from the Hydraulic Control Unit (HCU) during the bleeding process.', 'Electronic Brake Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Using DOT 5 silicone brake fluid', FALSE),
((SELECT MAX(id) FROM questions), 'Using a scan tool to cycle the ABS valves', TRUE),
((SELECT MAX(id) FROM questions), 'Bleeding the master cylinder last', FALSE),
((SELECT MAX(id) FROM questions), 'Disconnecting the wheel speed sensors', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A technician is performing a voltage drop test on the positive side of the alternator output circuit. The engine is running and all accessories are turned on. The multimeter reads 0.8 volts. What does this indicate?', 'A voltage drop of 0.8V on the B+ wire is too high (specification is usually 0.5V or less). This indicates high resistance in the wire or connections between the alternator and the battery.', 'Charging Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Normal circuit operation', FALSE),
((SELECT MAX(id) FROM questions), 'High resistance in the alternator output circuit', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty voltage regulator', FALSE),
((SELECT MAX(id) FROM questions), 'A slipping alternator belt', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A Hall-effect sensor is being tested with an oscilloscope. What type of waveform should the technician expect to see?', 'A Hall-effect sensor produces a digital, square-wave signal (toggling between a high and low voltage, such as 5V and 0V) as the magnetic field is interrupted.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'An analog AC sine wave', FALSE),
((SELECT MAX(id) FROM questions), 'A digital square wave', TRUE),
((SELECT MAX(id) FROM questions), 'A flat DC voltage line', FALSE),
((SELECT MAX(id) FROM questions), 'A saw-tooth wave', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'The left headlight is very dim. The right headlight is normal. A voltage drop test on the ground circuit of the left headlight shows 4.5 volts. What is the most likely cause?', 'A voltage drop of 4.5V on the ground side means the circuit is losing 4.5 volts pushing through a poor connection to ground, leaving less voltage for the bulb, causing it to be dim.', 'Lighting Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A burned-out headlight bulb', FALSE),
((SELECT MAX(id) FROM questions), 'A poor ground connection at the left headlight', TRUE),
((SELECT MAX(id) FROM questions), 'High resistance in the headlight switch', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty headlight relay', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'In an A/C system equipped with an orifice tube, where is the orifice tube typically located?', 'The orifice tube is the expansion device and is located in the high-pressure liquid line, usually between the condenser outlet and the evaporator inlet.', 'A/C System Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Between the evaporator and the compressor', FALSE),
((SELECT MAX(id) FROM questions), 'Between the condenser and the evaporator', TRUE),
((SELECT MAX(id) FROM questions), 'Inside the accumulator', FALSE),
((SELECT MAX(id) FROM questions), 'Between the compressor and the condenser', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A technician is checking condenser subcooling. Subcooling is defined as the difference between the:', 'Subcooling is the difference between the refrigerant''s saturation temperature (condensing temperature based on pressure) and its actual liquid temperature leaving the condenser.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Condensing temperature and the actual liquid temperature leaving the condenser', TRUE),
((SELECT MAX(id) FROM questions), 'Evaporating temperature and the actual vapor temperature leaving the evaporator', FALSE),
((SELECT MAX(id) FROM questions), 'Ambient air temperature and the center vent temperature', FALSE),
((SELECT MAX(id) FROM questions), 'High-side pressure and low-side pressure', FALSE);

-- ==========================================
-- A8: Engine Performance
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A scan tool shows Long Term Fuel Trim (LTFT) is +15% at idle, but drops to +2% when the engine is held at 2500 RPM. What is the most likely cause?', 'A vacuum leak has a massive effect at idle when total airflow is low (causing a lean condition and high positive fuel trim). At 2500 RPM, total airflow is high, so the small vacuum leak becomes negligible, and fuel trim returns to normal.', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Low fuel pressure', FALSE),
((SELECT MAX(id) FROM questions), 'A vacuum leak', TRUE),
((SELECT MAX(id) FROM questions), 'A restricted fuel injector', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty Mass Air Flow (MAF) sensor', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'Technician A says a faulty Engine Coolant Temperature (ECT) sensor that reads too cold can cause a rich fuel mixture. Technician B says a faulty ECT sensor that reads too cold can prevent the torque converter clutch (TCC) from engaging. Who is right?', 'Both are correct. If the PCM thinks the engine is cold, it will command a rich mixture (like a choke) and will inhibit TCC engagement until the engine reaches operating temperature.', 'Engine Sensors', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A1: Engine Repair (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A cylinder leakage test is being performed. Air is heard escaping from the tailpipe. What does this indicate?', 'Air escaping from the tailpipe during a cylinder leakage test indicates that the exhaust valve is not sealing properly against its seat.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A leaking intake valve', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking exhaust valve', TRUE),
((SELECT MAX(id) FROM questions), 'Worn piston rings', FALSE),
((SELECT MAX(id) FROM questions), 'A blown head gasket', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Technician A says a warped cylinder head can cause coolant to leak into the combustion chamber. Technician B says a cracked engine block can cause oil to mix with coolant. Who is right?', 'Both are correct. A warped head prevents the head gasket from sealing (allowing coolant into the cylinder), and a cracked block can breach the oil and coolant galleries.', 'Engine Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A transmission fluid temperature (TFT) sensor is being tested. As the fluid temperature increases, the resistance of a typical NTC thermistor TFT sensor should:', 'A Negative Temperature Coefficient (NTC) thermistor decreases in electrical resistance as its temperature increases.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Increase', FALSE),
((SELECT MAX(id) FROM questions), 'Decrease', TRUE),
((SELECT MAX(id) FROM questions), 'Remain constant', FALSE),
((SELECT MAX(id) FROM questions), 'Fluctuate rapidly', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'Which of the following is the most likely cause of a whining noise from the transmission that increases with engine RPM in all gears, including Park and Neutral?', 'The transmission oil pump is driven directly by the torque converter hub and turns at engine speed in all gear positions. A worn pump will whine constantly.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn planetary gearset', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty transmission oil pump', TRUE),
((SELECT MAX(id) FROM questions), 'A slipping overdrive band', FALSE),
((SELECT MAX(id) FROM questions), 'A worn output shaft bearing', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A rear-wheel-drive vehicle has a clunking noise when shifting from Park to Drive, or when accelerating and decelerating. What is the most likely cause?', 'A clunking noise during driveline load reversals (shifting into gear or accelerating/decelerating) is the classic symptom of worn U-joints.', 'Driveshaft Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn universal joints (U-joints)', TRUE),
((SELECT MAX(id) FROM questions), 'A warped clutch disc', FALSE),
((SELECT MAX(id) FROM questions), 'Low differential fluid', FALSE),
((SELECT MAX(id) FROM questions), 'Worn synchronizer rings', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'When checking the fluid level in a manual transmission, the fluid should be:', 'On most manual transmissions, the fluid level should be exactly even with the bottom edge of the side fill plug hole.', 'Transmission Maintenance', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), '1 inch below the fill hole', FALSE),
((SELECT MAX(id) FROM questions), 'Even with the bottom of the fill hole', TRUE),
((SELECT MAX(id) FROM questions), 'Checked with the engine running', FALSE),
((SELECT MAX(id) FROM questions), 'Checked using the transmission dipstick', FALSE);

-- ==========================================
-- A4: Suspension & Steering (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle has a harsh ride and bottoms out easily over bumps. The ride height is measured and found to be 2 inches below specification. What is the most likely cause?', 'Ride height is determined entirely by the springs (coil, leaf, or torsion bar). Sagging or broken springs will lower the ride height and cause bottoming out.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn shock absorbers', FALSE),
((SELECT MAX(id) FROM questions), 'Sagging or weak springs', TRUE),
((SELECT MAX(id) FROM questions), 'Worn control arm bushings', FALSE),
((SELECT MAX(id) FROM questions), 'Incorrect wheel alignment', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Technician A says excessive toe-in will cause the outside edges of the front tires to wear rapidly. Technician B says excessive negative camber will cause the inside edges of the tires to wear. Who is right?', 'Both are correct. Toe-in drags the outside edge of the tire across the pavement, and negative camber leans the tire inward, putting the vehicle weight on the inside edge.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A5: Brakes (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle with disc brakes pulls to the right during hard braking. The most likely cause is:', 'If the vehicle pulls to the right, the right brake is working harder than the left. This is usually caused by a seized caliper or restricted brake hose on the LEFT side, preventing it from applying.', 'Brake Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A seized right front brake caliper', FALSE),
((SELECT MAX(id) FROM questions), 'A seized left front brake caliper', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty master cylinder', FALSE),
((SELECT MAX(id) FROM questions), 'Air in the right front brake line', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the purpose of the metering valve in a disc/drum brake system?', 'The metering valve delays hydraulic pressure to the front disc brakes until the rear drum brake shoes overcome return spring tension and contact the drums, ensuring all brakes apply simultaneously.', 'Hydraulic System', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To prevent rear wheel lockup during hard braking', FALSE),
((SELECT MAX(id) FROM questions), 'To delay front brake application until rear brakes engage', TRUE),
((SELECT MAX(id) FROM questions), 'To warn the driver of a hydraulic leak', FALSE),
((SELECT MAX(id) FROM questions), 'To maintain residual pressure in the front brake lines', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A technician is testing a battery with a multimeter. The engine is off, and the battery voltage reads 12.0 volts. What is the state of charge of this battery?', 'A fully charged 12-volt automotive battery should read 12.6 volts. A reading of 12.0 volts indicates the battery is only at about 25% state of charge and needs to be recharged.', 'Battery Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), '100% charged', FALSE),
((SELECT MAX(id) FROM questions), '75% charged', FALSE),
((SELECT MAX(id) FROM questions), '50% charged', FALSE),
((SELECT MAX(id) FROM questions), '25% charged or lower', TRUE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When replacing a blown fuse, the technician notices the new fuse blows immediately when the circuit is turned on. What is the most likely cause?', 'A fuse blows immediately when there is a direct path to ground before the load (a short to ground), causing a massive spike in amperage that exceeds the fuse rating.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'An open circuit', FALSE),
((SELECT MAX(id) FROM questions), 'High resistance in the circuit', FALSE),
((SELECT MAX(id) FROM questions), 'A short to ground', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty relay coil', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'Which of the following is the correct procedure for adding refrigerant to an A/C system using a manifold gauge set?', 'Refrigerant should always be added to the low-pressure side of the system while the compressor is running. Adding to the high side can cause the refrigerant can to explode.', 'A/C System Service', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Add liquid to the high side with the engine off', FALSE),
((SELECT MAX(id) FROM questions), 'Add vapor to the low side with the engine running', TRUE),
((SELECT MAX(id) FROM questions), 'Add liquid to the low side with the engine off', FALSE),
((SELECT MAX(id) FROM questions), 'Add vapor to the high side with the engine running', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A vehicle''s heater blows only lukewarm air. The engine temperature gauge reads normal. Both heater hoses are hot to the touch. What is the most likely cause?', 'If both heater hoses are hot, hot coolant is flowing through the core. The issue is likely a blend door that is stuck halfway, mixing cold outside air with the heated air.', 'Heating System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A clogged heater core', FALSE),
((SELECT MAX(id) FROM questions), 'A stuck open thermostat', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty blend door actuator', TRUE),
((SELECT MAX(id) FROM questions), 'Low engine coolant', FALSE);

-- ==========================================
-- A8: Engine Performance (Batch 1)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A vehicle has a rough idle and a P0300 (Random Misfire) code. The fuel trims are +20% at idle but drop to +3% at 2500 RPM. What is the most likely cause?', 'High positive fuel trim at idle that corrects itself at higher RPMs is the classic signature of a vacuum leak (unmetered air entering the intake).', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A weak fuel pump', FALSE),
((SELECT MAX(id) FROM questions), 'A vacuum leak', TRUE),
((SELECT MAX(id) FROM questions), 'A clogged fuel filter', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty ignition coil', FALSE);

INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'Technician A says a faulty Throttle Position Sensor (TPS) can cause a hesitation during acceleration. Technician B says a dirty Mass Air Flow (MAF) sensor can cause a lean condition. Who is right?', 'Both are correct. The TPS provides acceleration enrichment data (like an accelerator pump), and a dirty MAF under-reports airflow, causing the PCM to inject too little fuel (lean condition).', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A1: Engine Repair (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When performing a cooling system pressure test, the pressure drops slowly but there are no external leaks visible. What is the most likely cause?', 'A slow drop in pressure with no external leaks indicates an internal leak, such as a blown head gasket or a cracked cylinder head/block allowing coolant into the combustion chamber or oil crankcase.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty radiator cap', FALSE),
((SELECT MAX(id) FROM questions), 'An internal coolant leak', TRUE),
((SELECT MAX(id) FROM questions), 'A restricted radiator core', FALSE),
((SELECT MAX(id) FROM questions), 'A slipping water pump belt', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A vehicle has no engine braking in manual 1st gear. Which component is most likely at fault?', 'In manual 1st gear, a specific band or clutch (often the low/reverse band) is applied to provide engine braking. If it fails, the transmission will freewheel on deceleration.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The forward clutch', FALSE),
((SELECT MAX(id) FROM questions), 'The low/reverse band or clutch', TRUE),
((SELECT MAX(id) FROM questions), 'The torque converter clutch', FALSE),
((SELECT MAX(id) FROM questions), 'The overdrive band', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A manual transmission jumps out of 3rd gear when decelerating. What is the most likely cause?', 'Jumping out of gear on deceleration is typically caused by worn synchronizer sleeve teeth, worn gear engagement teeth, or excessive end play in the main shaft.', 'Transmission Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn pilot bearing', FALSE),
((SELECT MAX(id) FROM questions), 'Worn synchronizer sleeve or gear teeth', TRUE),
((SELECT MAX(id) FROM questions), 'A dragging clutch', FALSE),
((SELECT MAX(id) FROM questions), 'Low transmission fluid', FALSE);

-- ==========================================
-- A4: Suspension & Steering (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Technician A says excessive positive caster can cause a hard steering complaint. Technician B says unequal caster can cause the vehicle to pull to one side. Who is right?', 'Both are correct. High positive caster increases steering effort, and unequal caster causes the vehicle to pull toward the side with the least positive (most negative) caster.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A5: Brakes (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle equipped with disc brakes has a soft, spongy brake pedal. Technician A says air in the hydraulic system could be the cause. Technician B says a seized caliper slide pin could be the cause. Who is right?', 'Air in the hydraulic system compresses, causing a spongy pedal. A seized caliper slide pin typically causes uneven pad wear or a pull, not a spongy pedal.', 'Brake Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', TRUE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When testing a circuit with a test light, the light illuminates dimly. What does this indicate?', 'A dim test light indicates that there is voltage present, but there is high resistance in the circuit reducing the current flow.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A complete open circuit', FALSE),
((SELECT MAX(id) FROM questions), 'A short to ground', FALSE),
((SELECT MAX(id) FROM questions), 'High resistance in the circuit', TRUE),
((SELECT MAX(id) FROM questions), 'Normal circuit operation', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'An A/C system with a Thermostatic Expansion Valve (TXV) has normal low-side pressure but very low high-side pressure. What is the most likely cause?', 'If the high-side pressure is low but the low-side is normal or high, the compressor is failing to pump efficiently (weak compressor).', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted TXV', FALSE),
((SELECT MAX(id) FROM questions), 'A weak A/C compressor', TRUE),
((SELECT MAX(id) FROM questions), 'An overcharge of refrigerant', FALSE),
((SELECT MAX(id) FROM questions), 'A clogged condenser', FALSE);

-- ==========================================
-- A8: Engine Performance (Batch 2)
-- ==========================================
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A vehicle has a P0113 code (Intake Air Temperature Sensor 1 Circuit High). What does a "Circuit High" code typically indicate on a thermistor circuit?', 'On a 5-volt reference thermistor circuit, a "Circuit High" code means the PCM is seeing the full 5 volts, which indicates an open circuit (broken wire or unplugged sensor).', 'Engine Sensors', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A short to ground', FALSE),
((SELECT MAX(id) FROM questions), 'An open circuit', TRUE),
((SELECT MAX(id) FROM questions), 'A short to voltage', FALSE),
((SELECT MAX(id) FROM questions), 'Normal operation in cold weather', FALSE);

-- ==========================================
-- A1: Engine Repair (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When resurfacing a cylinder head on an overhead cam (OHC) engine, what must also be considered to maintain proper valve train geometry?', 'Resurfacing the head moves the camshaft closer to the crankshaft, which can retard valve timing and reduce timing belt/chain tension. Cam timing may need to be adjusted or a shim used.', 'Cylinder Head Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Piston ring gap', FALSE),
((SELECT MAX(id) FROM questions), 'Valve timing and belt/chain tension', TRUE),
((SELECT MAX(id) FROM questions), 'Crankshaft end play', FALSE),
((SELECT MAX(id) FROM questions), 'Oil pump clearance', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A technician is checking engine oil pressure. The pressure is normal at cold idle but drops significantly below specification when the engine reaches operating temperature. What is the most likely cause?', 'As oil heats up, it thins out. Excessive bearing clearance allows this thinner oil to escape too quickly, causing a drop in pressure when hot.', 'Lubrication Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A stuck closed oil pressure relief valve', FALSE),
((SELECT MAX(id) FROM questions), 'Excessive main and rod bearing clearance', TRUE),
((SELECT MAX(id) FROM questions), 'A clogged oil filter', FALSE),
((SELECT MAX(id) FROM questions), 'Using oil with too high of a viscosity', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Which of the following symptoms is most commonly associated with worn valve guide seals?', 'Worn valve guide seals allow oil to seep down the valve stems and pool in the cylinders when the engine is off, resulting in a puff of blue smoke upon startup.', 'Cylinder Head Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Continuous black smoke from the exhaust', FALSE),
((SELECT MAX(id) FROM questions), 'Blue smoke from the exhaust immediately after starting a cold engine', TRUE),
((SELECT MAX(id) FROM questions), 'Coolant mixing with the engine oil', FALSE),
((SELECT MAX(id) FROM questions), 'A loud knocking noise under heavy acceleration', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'When installing a piston and connecting rod assembly into a cylinder block, the "front" mark or notch on the piston crown should face:', 'Pistons are often directional due to pin offset. The notch or arrow must face the front of the engine to prevent piston slap and uneven wear.', 'Engine Block Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Toward the rear of the engine', FALSE),
((SELECT MAX(id) FROM questions), 'Toward the camshaft', FALSE),
((SELECT MAX(id) FROM questions), 'Toward the front of the engine', TRUE),
((SELECT MAX(id) FROM questions), 'Toward the thrust side of the cylinder', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'An engine takes a very long time to reach normal operating temperature, and the heater blows lukewarm air. What is the most likely cause?', 'A thermostat that is stuck open allows coolant to circulate through the radiator constantly, preventing the engine from reaching operating temperature quickly.', 'Cooling Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A thermostat stuck closed', FALSE),
((SELECT MAX(id) FROM questions), 'A clogged radiator core', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty water pump impeller', FALSE),
((SELECT MAX(id) FROM questions), 'A thermostat stuck open', TRUE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Coolant is found leaking from a freeze plug (core plug) on the side of the engine block. Technician A says this can be caused by freezing coolant. Technician B says this can be caused by cooling system corrosion. Who is right?', 'Core plugs can be pushed out if the coolant freezes and expands, or they can rust through from the inside due to depleted coolant additives and corrosion.', 'Engine Block Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A rattling noise is heard from the front of the engine on startup, but it goes away after a few seconds. The engine is equipped with a timing chain. What is the most likely cause?', 'Hydraulic timing chain tensioners rely on oil pressure. If the tensioner bleeds down while sitting, the chain will rattle on startup until oil pressure builds up and extends the tensioner.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn main bearings', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty hydraulic timing chain tensioner', TRUE),
((SELECT MAX(id) FROM questions), 'A cracked flexplate', FALSE),
((SELECT MAX(id) FROM questions), 'A loose serpentine belt', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'A cylinder compression test shows two adjacent cylinders have very low compression (e.g., 30 psi), while the other cylinders are normal. What is the most likely cause?', 'When a head gasket blows out between two adjacent cylinders, compression from one cylinder leaks directly into the other, resulting in very low readings on both.', 'Engine Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn piston rings on both cylinders', FALSE),
((SELECT MAX(id) FROM questions), 'Two burned exhaust valves', FALSE),
((SELECT MAX(id) FROM questions), 'A blown head gasket between the two cylinders', TRUE),
((SELECT MAX(id) FROM questions), 'A jumped timing chain', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Excessive crankshaft end play is usually caused by wear on which of the following components?', 'The thrust bearing (or thrust washers) controls the forward and backward movement (end play) of the crankshaft.', 'Engine Block Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The main bearings', FALSE),
((SELECT MAX(id) FROM questions), 'The thrust bearing', TRUE),
((SELECT MAX(id) FROM questions), 'The connecting rod bearings', FALSE),
((SELECT MAX(id) FROM questions), 'The harmonic balancer', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A1'), 'Technician A says that solid lifters (tappets) require periodic valve clearance adjustments. Technician B says that hydraulic lifters automatically compensate for valve train wear. Who is right?', 'Solid lifters require manual adjustment to maintain proper clearance. Hydraulic lifters use engine oil pressure to maintain zero lash, automatically compensating for wear.', 'Cylinder Head Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- ==========================================
-- A2: Automatic Transmission/Transaxle (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'Automatic transmission fluid appears milky and pink. What is the most likely cause?', 'Milky, pink transmission fluid is a classic indicator that engine coolant has mixed with the ATF, usually due to a ruptured internal transmission cooler inside the radiator.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Aeration from overfilling the transmission', FALSE),
((SELECT MAX(id) FROM questions), 'Engine coolant leaking into the transmission cooler', TRUE),
((SELECT MAX(id) FROM questions), 'Severe overheating of the transmission fluid', FALSE),
((SELECT MAX(id) FROM questions), 'Normal fluid degradation over time', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A vehicle experiences a shudder only when the Torque Converter Clutch (TCC) applies. Technician A says degraded transmission fluid could be the cause. Technician B says an engine ignition misfire could be the cause. Who is right?', 'Both are correct. Degraded fluid can cause the TCC friction material to slip and grab (shudder). An engine misfire is also heavily felt when the TCC locks up because there is no longer fluid coupling to absorb the engine vibrations.', 'Torque Converter Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A transmission has harsh engagements and harsh upshifts in all gears. A line pressure test shows maximum pressure at all times. What is the most likely cause?', 'If the Electronic Pressure Control (EPC) solenoid fails or loses electrical connection, the transmission defaults to maximum line pressure to prevent clutch slippage, resulting in harsh shifts.', 'Hydraulic System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A stuck open pressure relief valve', FALSE),
((SELECT MAX(id) FROM questions), 'A failed or disconnected Electronic Pressure Control (EPC) solenoid', TRUE),
((SELECT MAX(id) FROM questions), 'A clogged transmission fluid filter', FALSE),
((SELECT MAX(id) FROM questions), 'Worn forward clutch plates', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'The transmission Input Speed Sensor (ISS) and Output Speed Sensor (OSS) are used by the PCM primarily to calculate:', 'The PCM compares the input speed to the output speed to determine the current gear ratio and to detect if any internal clutches or bands are slipping.', 'Electronic Controls', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Engine load and throttle position', FALSE),
((SELECT MAX(id) FROM questions), 'Gear ratio and transmission slip', TRUE),
((SELECT MAX(id) FROM questions), 'Torque converter stall speed', FALSE),
((SELECT MAX(id) FROM questions), 'Transmission fluid temperature', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'Excessive wear on a transmission extension housing bushing will most likely cause:', 'The extension housing bushing supports the slip yoke. If it wears out, the yoke will wobble, causing a driveline vibration and ruining the rear seal, leading to a fluid leak.', 'Transmission Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A fluid leak at the rear seal and driveline vibration', TRUE),
((SELECT MAX(id) FROM questions), 'Harsh shifting into overdrive', FALSE),
((SELECT MAX(id) FROM questions), 'Delayed engagement into reverse', FALSE),
((SELECT MAX(id) FROM questions), 'A whining noise in all forward gears', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A scan tool reveals a shift solenoid electrical fault code. When testing the solenoid with a digital multimeter, the resistance is infinite (OL). What does this indicate?', 'An infinite resistance reading (OL) on a multimeter means there is no continuity, indicating an open circuit (a broken wire or burned-out coil) inside the solenoid.', 'Electronic Controls', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A short to ground in the solenoid', FALSE),
((SELECT MAX(id) FROM questions), 'An open circuit in the solenoid coil', TRUE),
((SELECT MAX(id) FROM questions), 'The solenoid is functioning normally', FALSE),
((SELECT MAX(id) FROM questions), 'The solenoid is mechanically stuck closed', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'When checking the fluid level on a "sealed" transmission that does not have a dipstick, the technician must usually:', 'On most modern sealed transmissions, the fluid temperature must be monitored with a scan tool to ensure it is within a specific range (e.g., 95°F - 115°F) before opening the check plug to verify the level.', 'Transmission Maintenance', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Check the fluid with the engine off and cold', FALSE),
((SELECT MAX(id) FROM questions), 'Monitor fluid temperature with a scan tool before opening the check plug', TRUE),
((SELECT MAX(id) FROM questions), 'Fill the transmission until fluid comes out of the top vent tube', FALSE),
((SELECT MAX(id) FROM questions), 'Measure the fluid drained and add exactly the same amount back', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'In a simple planetary gearset, driving the planetary carrier while holding the ring gear stationary will cause the sun gear to:', 'If the carrier is the input and the ring gear is held, the pinions walk around the inside of the ring gear, forcing the sun gear to turn faster than the carrier, resulting in an overdrive ratio.', 'Planetary Gearsets', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Turn slower than the input (gear reduction)', FALSE),
((SELECT MAX(id) FROM questions), 'Turn at the same speed as the input (direct drive)', FALSE),
((SELECT MAX(id) FROM questions), 'Turn faster than the input (overdrive)', TRUE),
((SELECT MAX(id) FROM questions), 'Turn in the opposite direction (reverse)', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'A vehicle has a delayed engagement when shifted into Drive, but Reverse engages normally. The fluid level is correct. What is the most likely cause?', 'Because Reverse works normally, the pump and main line pressure are likely fine. A delayed engagement into Drive points to a slow-applying forward clutch, often caused by hardened or leaking forward clutch piston seals.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty transmission oil pump', FALSE),
((SELECT MAX(id) FROM questions), 'Leaking forward clutch piston seals', TRUE),
((SELECT MAX(id) FROM questions), 'A broken reverse band', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty torque converter stator', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A2'), 'Which type of transmission oil pump can change its output volume based on pressure demands?', 'A variable displacement vane pump can change the eccentricity of its slide ring to increase or decrease fluid volume output based on the transmission''s hydraulic demands, improving efficiency.', 'Transmission Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Gear pump', FALSE),
((SELECT MAX(id) FROM questions), 'Gerotor pump', FALSE),
((SELECT MAX(id) FROM questions), 'Variable displacement vane pump', TRUE),
((SELECT MAX(id) FROM questions), 'Centrifugal pump', FALSE);

-- ==========================================
-- A3: Manual Drive Train & Axles (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A driver notices brake fluid dripping down the clutch pedal arm inside the cabin. What is the most likely cause?', 'The clutch master cylinder is mounted on the firewall. If its rear seal fails, hydraulic fluid will leak directly into the cabin and drip down the clutch pedal arm.', 'Clutch Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A leaking clutch slave cylinder', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking clutch master cylinder rear seal', TRUE),
((SELECT MAX(id) FROM questions), 'A ruptured hydraulic clutch line', FALSE),
((SELECT MAX(id) FROM questions), 'Overfilled clutch fluid reservoir', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A front-wheel-drive vehicle experiences a severe vibration only during hard acceleration. The vibration goes away when coasting. What is the most likely cause?', 'The inner Constant Velocity (CV) joint is a plunge joint that moves in and out as the suspension travels. Wear in the inner CV joint typically causes a vibration under acceleration.', 'Drivetrain Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn outer CV joint', FALSE),
((SELECT MAX(id) FROM questions), 'A worn inner CV joint', TRUE),
((SELECT MAX(id) FROM questions), 'An out-of-balance tire', FALSE),
((SELECT MAX(id) FROM questions), 'A warped brake rotor', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A whining noise is heard from the rear axle only during deceleration (coasting). What is the most likely cause?', 'A whine that occurs only on deceleration usually indicates a loose pinion bearing preload or a worn rear pinion bearing, which allows the pinion gear to shift away from the ring gear when coasting.', 'Axle Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn carrier bearings', FALSE),
((SELECT MAX(id) FROM questions), 'Loose pinion bearing preload', TRUE),
((SELECT MAX(id) FROM questions), 'Worn axle shaft bearings', FALSE),
((SELECT MAX(id) FROM questions), 'Insufficient ring gear backlash', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'What is the purpose of adding a friction modifier to the gear oil in a limited-slip differential (LSD)?', 'Friction modifiers are added to limited-slip differentials to allow the clutch packs to slip smoothly during cornering, preventing a harsh chatter or binding sensation.', 'Axle Maintenance', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To increase the locking force of the clutches', FALSE),
((SELECT MAX(id) FROM questions), 'To prevent clutch chatter during turns', TRUE),
((SELECT MAX(id) FROM questions), 'To clean the gear teeth', FALSE),
((SELECT MAX(id) FROM questions), 'To lower the freezing point of the gear oil', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'Which component inside a manual transmission prevents the driver from engaging two gears at the same time?', 'The interlock mechanism (usually consisting of detent balls and interlock pins) physically blocks the other shift rails from moving once one shift rail is moved into a gear position.', 'Transmission Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The synchronizer sleeve', FALSE),
((SELECT MAX(id) FROM questions), 'The interlock mechanism', TRUE),
((SELECT MAX(id) FROM questions), 'The blocking ring', FALSE),
((SELECT MAX(id) FROM questions), 'The countershaft gear cluster', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A customer complains of a rapid pulsation felt in the clutch pedal when resting their foot lightly on the pedal with the engine running. What is the most likely cause?', 'Pulsation felt in the clutch pedal is typically caused by uneven contact between the release bearing and the pressure plate, usually due to warped or uneven pressure plate release fingers.', 'Clutch Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn clutch disc friction material', FALSE),
((SELECT MAX(id) FROM questions), 'Warped pressure plate release fingers', TRUE),
((SELECT MAX(id) FROM questions), 'Air in the hydraulic system', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking rear main engine seal', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'In a rear-wheel-drive solid axle assembly, which type of axle shaft supports the weight of the vehicle AND transmits driving torque to the wheels?', 'In a semi-floating axle design, the axle shaft itself supports the weight of the vehicle (via the wheel bearing) and also transmits the rotational torque to the wheel flange.', 'Axle Theory', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Full-floating axle', FALSE),
((SELECT MAX(id) FROM questions), 'Semi-floating axle', TRUE),
((SELECT MAX(id) FROM questions), 'Three-quarter floating axle', FALSE),
((SELECT MAX(id) FROM questions), 'Independent rear suspension (IRS) axle', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A manual transmission grinds when shifting into reverse. All forward gears shift smoothly. What is the most likely cause?', 'Unlike forward gears, reverse gear in most manual transmissions is not synchronized. If the clutch is dragging (not fully releasing), the input shaft will continue to spin, causing a grind when trying to engage the non-synchronized reverse idler gear.', 'Transmission Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn reverse synchronizer ring', FALSE),
((SELECT MAX(id) FROM questions), 'A dragging clutch', TRUE),
((SELECT MAX(id) FROM questions), 'Worn 1st-2nd shift fork', FALSE),
((SELECT MAX(id) FROM questions), 'Low transmission fluid', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'When measuring flywheel runout with a dial indicator, the reading exceeds the manufacturer''s specification. What is the proper repair procedure?', 'If a flywheel has excessive runout (warpage), it must be resurfaced by a machine shop to restore a flat mating surface, or replaced if it is below the minimum thickness specification.', 'Clutch Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Install a thicker clutch disc', FALSE),
((SELECT MAX(id) FROM questions), 'Resurface or replace the flywheel', TRUE),
((SELECT MAX(id) FROM questions), 'Shim the pressure plate', FALSE),
((SELECT MAX(id) FROM questions), 'Ignore it, as the clutch disc will conform to the shape', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A3'), 'A 4WD vehicle with a part-time transfer case experiences severe driveline binding and hopping when making tight turns on dry pavement. What is the most likely cause?', 'Part-time 4WD systems lock the front and rear driveshafts together. Because the front and rear axles travel different distances in a turn, driving in 4WD on dry pavement causes severe driveline bind.', 'Transfer Case Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A broken transfer case chain', FALSE),
((SELECT MAX(id) FROM questions), 'Normal operation for part-time 4WD on dry pavement', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty viscous coupling', FALSE),
((SELECT MAX(id) FROM questions), 'Worn front axle U-joints', FALSE);

-- ==========================================
-- A4: Suspension & Steering (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A tire shows a "feathered" wear pattern across its tread. What is the most likely cause of this type of wear?', 'Feathering (where tread ribs are smooth when rubbed one way but sharp when rubbed the other) is the classic indicator of an incorrect toe setting, which drags the tire sideways down the road.', 'Wheel and Tire Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Incorrect camber', FALSE),
((SELECT MAX(id) FROM questions), 'Incorrect toe', TRUE),
((SELECT MAX(id) FROM questions), 'Worn shock absorbers', FALSE),
((SELECT MAX(id) FROM questions), 'Underinflation', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle with a MacPherson strut suspension makes a loud popping or binding noise when the steering wheel is turned from lock to lock while stopped. What is the most likely cause?', 'The upper strut mount contains a bearing that allows the entire strut assembly to pivot when the wheels are turned. If this bearing binds or fails, the coil spring will wind up and pop as it releases tension.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A worn lower ball joint', FALSE),
((SELECT MAX(id) FROM questions), 'A binding upper strut mount bearing', TRUE),
((SELECT MAX(id) FROM questions), 'A loose outer tie rod end', FALSE),
((SELECT MAX(id) FROM questions), 'Low power steering fluid', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle "dog-tracks" (the rear of the vehicle does not follow directly behind the front) while driving straight down a level road. What alignment angle is out of specification?', 'Thrust angle is the direction the rear wheels are pointing relative to the vehicle centerline. An incorrect thrust angle pushes the rear of the vehicle to one side, causing dog-tracking.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Caster', FALSE),
((SELECT MAX(id) FROM questions), 'Camber', FALSE),
((SELECT MAX(id) FROM questions), 'Thrust angle', TRUE),
((SELECT MAX(id) FROM questions), 'Steering Axis Inclination (SAI)', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'When checking a lower load-carrying ball joint for wear on a Short/Long Arm (SLA) suspension where the coil spring sits on the lower control arm, where should the jack be placed?', 'To check a load-carrying ball joint, the weight of the vehicle must be taken off the joint. Placing the jack directly under the lower control arm compresses the spring and unloads the ball joint for accurate testing.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Under the frame rail', FALSE),
((SELECT MAX(id) FROM questions), 'Under the lower control arm, as close to the ball joint as possible', TRUE),
((SELECT MAX(id) FROM questions), 'Under the upper control arm', FALSE),
((SELECT MAX(id) FROM questions), 'Under the engine crossmember', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle equipped with Electronic Power Steering (EPS) has a heavy steering feel at low speeds. The EPS warning light is ON. A scan tool reveals a loss of the Vehicle Speed Sensor (VSS) signal. Why does this affect steering?', 'EPS systems use the VSS signal to provide maximum power assist at low speeds (for parking) and reduce assist at high speeds (for stability). Without the VSS signal, the system defaults to a safe, low-assist mode.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The VSS powers the EPS electric motor directly', FALSE),
((SELECT MAX(id) FROM questions), 'The EPS module needs vehicle speed data to determine the correct amount of steering assist', TRUE),
((SELECT MAX(id) FROM questions), 'The VSS controls the steering rack gear ratio', FALSE),
((SELECT MAX(id) FROM questions), 'The EPS system uses the VSS to center the steering wheel', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A customer complains of a clunking noise from the front suspension when driving over small bumps. The noise is not heard when braking. What is the most likely cause?', 'Worn sway bar (stabilizer bar) links or bushings are a very common cause of a hollow clunking noise over small bumps. Braking does not typically affect sway bar noise, whereas it might temporarily quiet a loose control arm or caliper.', 'Suspension Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn sway bar links or bushings', TRUE),
((SELECT MAX(id) FROM questions), 'A warped brake rotor', FALSE),
((SELECT MAX(id) FROM questions), 'A worn outer tie rod end', FALSE),
((SELECT MAX(id) FROM questions), 'A slipping power steering belt', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'Technician A says that Steering Axis Inclination (SAI) is a non-adjustable angle on most vehicles. Technician B says that SAI helps the steering wheel return to center after a turn. Who is right?', 'Both are correct. SAI is built into the steering knuckle/strut design and is generally not adjustable. Its inward tilt causes the vehicle chassis to lift slightly during a turn, and the vehicle weight pushes it back to center when the wheel is released.', 'Wheel Alignment', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A vehicle experiences "bump steer" (the steering wheel jerks to one side when hitting a bump). What is the most likely cause?', 'Bump steer occurs when the tie rods are not parallel to the lower control arms. As the suspension travels over a bump, the tie rod pulls on the steering knuckle, causing the wheel to turn without driver input. This is often caused by bent steering components or severely sagging springs.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Worn shock absorbers', FALSE),
((SELECT MAX(id) FROM questions), 'Tie rods that are not parallel to the control arms', TRUE),
((SELECT MAX(id) FROM questions), 'Excessive positive caster', FALSE),
((SELECT MAX(id) FROM questions), 'A loose steering wheel nut', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'When balancing a tire, the technician notices the wheel assembly requires an excessive amount of weight (over 4 ounces) to balance. What should the technician do next?', 'If a tire requires excessive weight, the technician should dismount the tire and rotate it 180 degrees on the rim (match mounting) to see if the heavy spot of the tire can cancel out the heavy spot of the wheel.', 'Wheel and Tire Service', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Add the weights and release the vehicle', FALSE),
((SELECT MAX(id) FROM questions), 'Deflate the tire and re-inflate it to a higher pressure', FALSE),
((SELECT MAX(id) FROM questions), 'Rotate the tire 180 degrees on the rim and recheck', TRUE),
((SELECT MAX(id) FROM questions), 'Replace the wheel bearing', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A4'), 'A power steering pump is being tested with a pressure gauge and a shut-off valve. When the valve is completely closed for 3 seconds, the pressure spikes to the maximum specification and the pump groans loudly. What does this indicate?', 'Closing the valve forces the pump to build maximum pressure until the internal pressure relief valve opens. If it reaches the specified maximum pressure, the pump and relief valve are operating normally.', 'Steering Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A weak power steering pump', FALSE),
((SELECT MAX(id) FROM questions), 'A stuck open pressure relief valve', FALSE),
((SELECT MAX(id) FROM questions), 'Normal pump and relief valve operation', TRUE),
((SELECT MAX(id) FROM questions), 'A restricted high-pressure hose', FALSE);

-- ==========================================
-- A5: Brakes (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the primary purpose of the square-cut O-ring seal located inside a disc brake caliper?', 'The square-cut O-ring seals the hydraulic fluid behind the piston, but its unique shape also acts as a spring. It distorts when the brakes are applied and pulls the piston back slightly when pressure is released, preventing pad drag.', 'Brake Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To prevent dust and moisture from entering the caliper bore', FALSE),
((SELECT MAX(id) FROM questions), 'To seal fluid and retract the caliper piston when the brakes are released', TRUE),
((SELECT MAX(id) FROM questions), 'To hold the brake pad tightly against the caliper bracket', FALSE),
((SELECT MAX(id) FROM questions), 'To dampen high-frequency vibrations and prevent brake squeal', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When performing a functional test on a vacuum brake booster, the technician depletes the vacuum by pumping the pedal with the engine off. The technician then holds the pedal down and starts the engine. What should happen if the booster is functioning properly?', 'When the engine starts, manifold vacuum is supplied to the booster. The vacuum assists the driver''s foot pressure, causing the brake pedal to drop slightly under steady foot pressure.', 'Power Assist Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The pedal should push back against the technician''s foot', FALSE),
((SELECT MAX(id) FROM questions), 'The pedal should remain exactly in the same position', FALSE),
((SELECT MAX(id) FROM questions), 'The pedal should drop slightly toward the floor', TRUE),
((SELECT MAX(id) FROM questions), 'The pedal should drop completely to the floor', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Which type of brake fluid is silicone-based and should NEVER be mixed with polyglycol-based fluids?', 'DOT 5 is a silicone-based brake fluid. It does not absorb water (hydrophobic) and will not mix with DOT 3, DOT 4, or DOT 5.1 (which are all polyglycol-based). Mixing them can cause seal damage and fluid coagulation.', 'Brake Fluid', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'DOT 3', FALSE),
((SELECT MAX(id) FROM questions), 'DOT 4', FALSE),
((SELECT MAX(id) FROM questions), 'DOT 5', TRUE),
((SELECT MAX(id) FROM questions), 'DOT 5.1', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle''s rear drum brakes are being serviced. Technician A says the parking brake cable should be adjusted before adjusting the brake shoes. Technician B says the star wheel adjuster threads should be lubricated with high-temperature brake grease. Who is right?', 'Technician B is correct. The star wheel threads should be lubricated to prevent seizing. Technician A is wrong because the brake shoes must ALWAYS be adjusted to the drum before adjusting the parking brake cable.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', TRUE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the purpose of applying a non-directional finish to a brake rotor after it has been machined on a lathe?', 'Machining a rotor leaves a continuous spiral groove (like a record). If left alone, the brake pads will follow this groove and click as they snap back. A non-directional finish breaks up this groove to prevent pad tracking and noise.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To increase the rotor''s resistance to heat warping', FALSE),
((SELECT MAX(id) FROM questions), 'To prevent the brake pads from tracking and causing a clicking noise', TRUE),
((SELECT MAX(id) FROM questions), 'To balance the rotor dynamically', FALSE),
((SELECT MAX(id) FROM questions), 'To allow the use of ceramic brake pads', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle with a diagonal split hydraulic brake system has a severe fluid leak at the right rear wheel cylinder. Which other wheel will lose its hydraulic braking power?', 'In a diagonal split system, the master cylinder operates opposite corners of the vehicle on the same hydraulic circuit (e.g., Right Rear and Left Front). If one leaks, the entire circuit loses pressure.', 'Hydraulic System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Right Front', FALSE),
((SELECT MAX(id) FROM questions), 'Left Rear', FALSE),
((SELECT MAX(id) FROM questions), 'Left Front', TRUE),
((SELECT MAX(id) FROM questions), 'None, the proportioning valve isolates the leak', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Active wheel speed sensors (such as magneto-resistive sensors) differ from older passive (variable reluctance) sensors in that active sensors:', 'Active wheel speed sensors require a power supply and produce a digital square wave signal. Because they do not rely on the speed of the tone ring to generate voltage, they can accurately read wheel speeds all the way down to 0 mph.', 'Electronic Brake Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Produce an analog AC voltage signal', FALSE),
((SELECT MAX(id) FROM questions), 'Can read wheel speeds down to zero mph', TRUE),
((SELECT MAX(id) FROM questions), 'Do not require an external power source', FALSE),
((SELECT MAX(id) FROM questions), 'Are only used on the rear wheels', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When fabricating a new steel brake line, which type of fitting is strictly prohibited for use in automotive hydraulic brake systems?', 'Compression fittings are strictly prohibited in hydraulic brake systems because they cannot withstand the extreme high pressures (often over 1,000 psi) generated during hard braking and will blow out.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Double flare fittings', FALSE),
((SELECT MAX(id) FROM questions), 'ISO bubble flare fittings', FALSE),
((SELECT MAX(id) FROM questions), 'Compression fittings', TRUE),
((SELECT MAX(id) FROM questions), 'Inverted flare fittings', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A customer complains of a hard brake pedal. The technician measures 18 in. Hg of vacuum at the booster check valve with the engine idling. What is the most likely cause of the hard pedal?', 'Normal engine vacuum is 17-21 in. Hg. Since the booster is receiving a good vacuum supply (18 in. Hg), the hard pedal is likely caused by a failure inside the booster itself (e.g., a torn diaphragm).', 'Power Assist Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted vacuum hose', FALSE),
((SELECT MAX(id) FROM questions), 'A defective brake booster', TRUE),
((SELECT MAX(id) FROM questions), 'A vacuum leak at the intake manifold', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty master cylinder primary piston', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the purpose of the compensating ports located inside the brake master cylinder?', 'The compensating ports allow brake fluid to flow between the reservoir and the pressure chambers when the brakes are released. This allows for fluid expansion due to heat and keeps the system full as the brake pads wear.', 'Hydraulic System', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To allow fluid expansion and return to the reservoir when brakes are released', TRUE),
((SELECT MAX(id) FROM questions), 'To proportion pressure between the front and rear brakes', FALSE),
((SELECT MAX(id) FROM questions), 'To delay front brake application on disc/drum systems', FALSE),
((SELECT MAX(id) FROM questions), 'To warn the driver if one half of the hydraulic system fails', FALSE);


-- ==========================================
-- A5: Brakes (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the primary purpose of the square-cut O-ring seal located inside a disc brake caliper?', 'The square-cut O-ring seals the hydraulic fluid behind the piston, but its unique shape also acts as a spring. It distorts when the brakes are applied and pulls the piston back slightly when pressure is released, preventing pad drag.', 'Brake Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To prevent dust and moisture from entering the caliper bore', FALSE),
((SELECT MAX(id) FROM questions), 'To seal fluid and retract the caliper piston when the brakes are released', TRUE),
((SELECT MAX(id) FROM questions), 'To hold the brake pad tightly against the caliper bracket', FALSE),
((SELECT MAX(id) FROM questions), 'To dampen high-frequency vibrations and prevent brake squeal', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When performing a functional test on a vacuum brake booster, the technician depletes the vacuum by pumping the pedal with the engine off. The technician then holds the pedal down and starts the engine. What should happen if the booster is functioning properly?', 'When the engine starts, manifold vacuum is supplied to the booster. The vacuum assists the driver''s foot pressure, causing the brake pedal to drop slightly under steady foot pressure.', 'Power Assist Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The pedal should push back against the technician''s foot', FALSE),
((SELECT MAX(id) FROM questions), 'The pedal should remain exactly in the same position', FALSE),
((SELECT MAX(id) FROM questions), 'The pedal should drop slightly toward the floor', TRUE),
((SELECT MAX(id) FROM questions), 'The pedal should drop completely to the floor', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Which type of brake fluid is silicone-based and should NEVER be mixed with polyglycol-based fluids?', 'DOT 5 is a silicone-based brake fluid. It does not absorb water (hydrophobic) and will not mix with DOT 3, DOT 4, or DOT 5.1 (which are all polyglycol-based). Mixing them can cause seal damage and fluid coagulation.', 'Brake Fluid', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'DOT 3', FALSE),
((SELECT MAX(id) FROM questions), 'DOT 4', FALSE),
((SELECT MAX(id) FROM questions), 'DOT 5', TRUE),
((SELECT MAX(id) FROM questions), 'DOT 5.1', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle''s rear drum brakes are being serviced. Technician A says the parking brake cable should be adjusted before adjusting the brake shoes. Technician B says the star wheel adjuster threads should be lubricated with high-temperature brake grease. Who is right?', 'Technician B is correct. The star wheel threads should be lubricated to prevent seizing. Technician A is wrong because the brake shoes must ALWAYS be adjusted to the drum before adjusting the parking brake cable.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', TRUE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', FALSE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the purpose of applying a non-directional finish to a brake rotor after it has been machined on a lathe?', 'Machining a rotor leaves a continuous spiral groove (like a record). If left alone, the brake pads will follow this groove and click as they snap back. A non-directional finish breaks up this groove to prevent pad tracking and noise.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To increase the rotor''s resistance to heat warping', FALSE),
((SELECT MAX(id) FROM questions), 'To prevent the brake pads from tracking and causing a clicking noise', TRUE),
((SELECT MAX(id) FROM questions), 'To balance the rotor dynamically', FALSE),
((SELECT MAX(id) FROM questions), 'To allow the use of ceramic brake pads', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A vehicle with a diagonal split hydraulic brake system has a severe fluid leak at the right rear wheel cylinder. Which other wheel will lose its hydraulic braking power?', 'In a diagonal split system, the master cylinder operates opposite corners of the vehicle on the same hydraulic circuit (e.g., Right Rear and Left Front). If one leaks, the entire circuit loses pressure.', 'Hydraulic System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Right Front', FALSE),
((SELECT MAX(id) FROM questions), 'Left Rear', FALSE),
((SELECT MAX(id) FROM questions), 'Left Front', TRUE),
((SELECT MAX(id) FROM questions), 'None, the proportioning valve isolates the leak', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'Active wheel speed sensors (such as magneto-resistive sensors) differ from older passive (variable reluctance) sensors in that active sensors:', 'Active wheel speed sensors require a power supply and produce a digital square wave signal. Because they do not rely on the speed of the tone ring to generate voltage, they can accurately read wheel speeds all the way down to 0 mph.', 'Electronic Brake Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Produce an analog AC voltage signal', FALSE),
((SELECT MAX(id) FROM questions), 'Can read wheel speeds down to zero mph', TRUE),
((SELECT MAX(id) FROM questions), 'Do not require an external power source', FALSE),
((SELECT MAX(id) FROM questions), 'Are only used on the rear wheels', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'When fabricating a new steel brake line, which type of fitting is strictly prohibited for use in automotive hydraulic brake systems?', 'Compression fittings are strictly prohibited in hydraulic brake systems because they cannot withstand the extreme high pressures (often over 1,000 psi) generated during hard braking and will blow out.', 'Brake Repair', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Double flare fittings', FALSE),
((SELECT MAX(id) FROM questions), 'ISO bubble flare fittings', FALSE),
((SELECT MAX(id) FROM questions), 'Compression fittings', TRUE),
((SELECT MAX(id) FROM questions), 'Inverted flare fittings', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'A customer complains of a hard brake pedal. The technician measures 18 in. Hg of vacuum at the booster check valve with the engine idling. What is the most likely cause of the hard pedal?', 'Normal engine vacuum is 17-21 in. Hg. Since the booster is receiving a good vacuum supply (18 in. Hg), the hard pedal is likely caused by a failure inside the booster itself (e.g., a torn diaphragm).', 'Power Assist Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted vacuum hose', FALSE),
((SELECT MAX(id) FROM questions), 'A defective brake booster', TRUE),
((SELECT MAX(id) FROM questions), 'A vacuum leak at the intake manifold', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty master cylinder primary piston', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A5'), 'What is the purpose of the compensating ports located inside the brake master cylinder?', 'The compensating ports allow brake fluid to flow between the reservoir and the pressure chambers when the brakes are released. This allows for fluid expansion due to heat and keeps the system full as the brake pads wear.', 'Hydraulic System', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To allow fluid expansion and return to the reservoir when brakes are released', TRUE),
((SELECT MAX(id) FROM questions), 'To proportion pressure between the front and rear brakes', FALSE),
((SELECT MAX(id) FROM questions), 'To delay front brake application on disc/drum systems', FALSE),
((SELECT MAX(id) FROM questions), 'To warn the driver if one half of the hydraulic system fails', FALSE);

-- ==========================================
-- A6: Electrical/Electronic Systems (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When testing a lead-acid battery with a hydrometer, all cells read 1.265 specific gravity except one, which reads 1.150. What does this indicate?', 'A difference of 0.050 or more in specific gravity between any two cells indicates a dead or shorted cell, meaning the battery is defective and must be replaced.', 'Battery Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The battery just needs a slow trickle charge', FALSE),
((SELECT MAX(id) FROM questions), 'The battery has a dead or shorted cell', TRUE),
((SELECT MAX(id) FROM questions), 'The battery is overcharged', FALSE),
((SELECT MAX(id) FROM questions), 'Normal operation for a maintenance-free battery', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A technician is performing a voltage drop test on the alternator ground circuit. The engine is running and accessories are on. The voltmeter reads 0.6 volts. What does this indicate?', 'A voltage drop of 0.6V on the ground side is too high (specification is usually 0.2V or less). This indicates a poor ground connection between the alternator housing and the engine block or battery negative.', 'Charging Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Normal circuit operation', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty voltage regulator', FALSE),
((SELECT MAX(id) FROM questions), 'High resistance in the alternator ground circuit', TRUE),
((SELECT MAX(id) FROM questions), 'A slipping alternator drive belt', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'An engine cranks very slowly. A starter current draw test shows the starter is drawing significantly LESS amperage than specified. What is the most likely cause?', 'Low current draw combined with slow cranking indicates high resistance in the starter circuit (e.g., corroded battery cables, loose connections) preventing sufficient current from reaching the starter motor.', 'Starting System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'An internal short in the starter motor', FALSE),
((SELECT MAX(id) FROM questions), 'High resistance in the starter circuit cables or connections', TRUE),
((SELECT MAX(id) FROM questions), 'A seized engine', FALSE),
((SELECT MAX(id) FROM questions), 'Advanced ignition timing', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A horn relay clicks when the horn button is pressed, but the horn does not sound. The technician verifies there is battery voltage at terminal 30 of the relay. What is the most likely cause?', 'If the relay clicks, the control circuit (terminals 85/86) is working. If there is power at terminal 30, the issue is either burned contacts inside the relay (terminal 87), a broken wire to the horn, or a faulty horn itself.', 'Electrical Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A blown fuse in the relay control circuit', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty horn switch in the steering wheel', FALSE),
((SELECT MAX(id) FROM questions), 'Burned contacts inside the relay or a faulty horn', TRUE),
((SELECT MAX(id) FROM questions), 'A short to ground in the relay coil', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A technician needs to measure the current flowing through a fuel pump circuit. How should the digital multimeter (DMM) be connected?', 'To measure current (amperage), the circuit must be broken and the meter connected in series so all current flows through the meter.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'In parallel across the fuel pump', FALSE),
((SELECT MAX(id) FROM questions), 'In series with the fuel pump circuit', TRUE),
((SELECT MAX(id) FROM questions), 'In parallel across the battery', FALSE),
((SELECT MAX(id) FROM questions), 'From the fuel pump power wire to a good ground', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'In an automotive wiring diagram, a dashed or dotted line drawn around a component typically indicates:', 'A dashed or dotted line around a component in a schematic usually indicates that only a portion of that component is being shown, or it is part of a larger assembly.', 'Electrical Fundamentals', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The component is grounded to the chassis', FALSE),
((SELECT MAX(id) FROM questions), 'The component is an optional accessory', FALSE),
((SELECT MAX(id) FROM questions), 'Only a portion of the component is shown, or it is part of an assembly', TRUE),
((SELECT MAX(id) FROM questions), 'The wiring is shielded against electromagnetic interference', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'Both turn signals flash at the normal rate, but the hazard warning flashers do not operate at all. What is the most likely cause?', 'Many vehicles use a separate power feed (battery direct vs. ignition fed) or a separate flasher relay for the hazard lights. A blown hazard fuse or faulty hazard flasher is the most likely cause.', 'Lighting Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A burned-out turn signal bulb', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty turn signal switch', FALSE),
((SELECT MAX(id) FROM questions), 'A blown hazard flasher fuse or faulty hazard flasher', TRUE),
((SELECT MAX(id) FROM questions), 'A short to ground in the left front turn signal housing', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'A Throttle Position Sensor (TPS) is being tested with an oscilloscope. The waveform shows a smooth upward line that suddenly drops to zero volts and comes right back up as the throttle is opened. What does this indicate?', 'A sudden drop to zero volts (a "dropout") indicates a worn or open spot in the carbon track of the potentiometer, requiring replacement of the sensor.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Normal TPS operation', FALSE),
((SELECT MAX(id) FROM questions), 'A worn or open spot in the sensor''s resistor track', TRUE),
((SELECT MAX(id) FROM questions), 'A short to 5-volt reference', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty PCM ground', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'Technician A says a High-Speed CAN bus uses two wires twisted together to reduce electromagnetic interference. Technician B says CAN High and CAN Low mirror each other''s voltage changes. Who is right?', 'Both are correct. The wires are twisted to cancel out EMI, and the signals are differential (mirror images) to ensure data integrity and noise immunity.', 'Network Communications', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A6'), 'When preparing to perform a parasitic draw test, why is it important to wait 30 to 60 minutes after turning off the ignition and closing the doors?', 'Modern vehicles have multiple control modules that remain awake after the key is turned off. It can take 30 to 60 minutes for all modules to "go to sleep" and drop to the true base parasitic draw.', 'Electrical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To allow the battery voltage to stabilize at 12.6 volts', FALSE),
((SELECT MAX(id) FROM questions), 'To allow the engine coolant to cool down', FALSE),
((SELECT MAX(id) FROM questions), 'To allow all electronic control modules to power down or "go to sleep"', TRUE),
((SELECT MAX(id) FROM questions), 'To bleed off residual fuel pressure', FALSE);

-- ==========================================
-- A7: Heating & Air Conditioning (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A customer complains that the A/C blows cold air while driving at highway speeds, but blows warm air when idling in traffic. What is the most likely cause?', 'At highway speeds, ram air flows through the condenser to cool the refrigerant. At idle, the system relies entirely on the engine cooling fan(s). If the fan fails, high-side pressure spikes and the A/C blows warm at idle.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty A/C compressor', FALSE),
((SELECT MAX(id) FROM questions), 'A restricted expansion valve', FALSE),
((SELECT MAX(id) FROM questions), 'An inoperative condenser cooling fan', TRUE),
((SELECT MAX(id) FROM questions), 'A stuck open thermostat', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'When pulling a vacuum on an A/C system prior to recharging, what is the primary purpose of the vacuum?', 'While a vacuum does remove air, its primary purpose is to lower the atmospheric pressure inside the system so that any trapped moisture boils into a vapor and is extracted by the vacuum pump.', 'A/C System Service', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To remove excess refrigerant oil', FALSE),
((SELECT MAX(id) FROM questions), 'To boil off and remove moisture from the system', TRUE),
((SELECT MAX(id) FROM questions), 'To test the compressor clutch operation', FALSE),
((SELECT MAX(id) FROM questions), 'To seat the O-rings and seals', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A rhythmic clicking or tapping noise is heard from under the dashboard whenever the temperature setting is changed from cold to hot. What is the most likely cause?', 'A clicking noise from under the dash when changing temperature is almost always caused by stripped plastic gears inside the electronic blend door actuator.', 'Heating System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty blower motor resistor', FALSE),
((SELECT MAX(id) FROM questions), 'A stripped blend door actuator gear', TRUE),
((SELECT MAX(id) FROM questions), 'A clogged heater core', FALSE),
((SELECT MAX(id) FROM questions), 'A failing A/C compressor', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'Which type of refrigerant oil is most commonly used in R-134a A/C systems?', 'PAG (Polyalkylene Glycol) oil is the standard synthetic oil used in factory R-134a systems. POE (Polyol Ester) is typically used for retrofits or hybrid electric compressors.', 'A/C System Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Mineral oil', FALSE),
((SELECT MAX(id) FROM questions), 'PAG (Polyalkylene Glycol) oil', TRUE),
((SELECT MAX(id) FROM questions), 'POE (Polyol Ester) oil', FALSE),
((SELECT MAX(id) FROM questions), 'Silicone oil', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A manifold gauge set is connected to an A/C system. The low-side pressure is higher than normal, and the high-side pressure is lower than normal. What is the most likely cause?', 'When the low side is high and the high side is low, the compressor is failing to create a pressure differential. This indicates an internally failing compressor or a stuck open expansion valve.', 'A/C System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted condenser', FALSE),
((SELECT MAX(id) FROM questions), 'A low refrigerant charge', FALSE),
((SELECT MAX(id) FROM questions), 'An internally failing A/C compressor', TRUE),
((SELECT MAX(id) FROM questions), 'A clogged orifice tube', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A customer complains of very low airflow from the dashboard vents, even when the blower motor is set to the highest speed. The blower motor can be heard running loudly. What is the most likely cause?', 'If the blower motor is running but airflow is weak, there is a restriction in the ductwork. The most common cause is a severely clogged cabin air filter.', 'Heating System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty blower motor resistor', FALSE),
((SELECT MAX(id) FROM questions), 'A clogged cabin air filter', TRUE),
((SELECT MAX(id) FROM questions), 'A low refrigerant charge', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty heater control valve', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'Technician A says that hybrid vehicles with electric A/C compressors require a specific type of non-conductive refrigerant oil. Technician B says using standard PAG oil in a hybrid electric compressor can cause a high-voltage insulation fault. Who is right?', 'Both are correct. Hybrid electric compressors have high-voltage windings exposed to the refrigerant oil. Standard PAG oil conducts electricity and will cause a fatal high-voltage short. POE oil (specifically formulated for hybrids) must be used.', 'A/C System Service', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Technician A only', FALSE),
((SELECT MAX(id) FROM questions), 'Technician B only', FALSE),
((SELECT MAX(id) FROM questions), 'Both Technician A and B', TRUE),
((SELECT MAX(id) FROM questions), 'Neither Technician A nor B', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'What is the purpose of the A/C compressor clutch air gap?', 'The air gap is the small clearance between the clutch hub and the pulley. If the gap is too large, the electromagnet cannot pull the hub in to engage the compressor. If it is too small, the clutch will drag when disengaged.', 'A/C System Components', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To allow the compressor to freewheel when the A/C is turned off', TRUE),
((SELECT MAX(id) FROM questions), 'To vent excess refrigerant pressure', FALSE),
((SELECT MAX(id) FROM questions), 'To lubricate the compressor shaft seal', FALSE),
((SELECT MAX(id) FROM questions), 'To measure the speed of the compressor', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'A vehicle''s heater blows cold air. The technician notices the inlet heater hose is hot, but the outlet heater hose is cold. What does this indicate?', 'If hot coolant is entering the heater core but not exiting, the heater core is internally restricted (clogged) and coolant is not flowing through it.', 'Heating System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A stuck open engine thermostat', FALSE),
((SELECT MAX(id) FROM questions), 'A restricted (clogged) heater core', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty blend door actuator', FALSE),
((SELECT MAX(id) FROM questions), 'A leaking water pump', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A7'), 'Before recovering refrigerant from a vehicle, why should a technician use a refrigerant identifier?', 'A refrigerant identifier ensures the system contains pure R-134a (or R-1234yf). Recovering contaminated or mixed refrigerants will contaminate the shop''s expensive recovery machine and bulk storage tank.', 'A/C System Service', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To determine the exact weight of the refrigerant in the system', FALSE),
((SELECT MAX(id) FROM questions), 'To prevent contamination of the shop''s recovery equipment', TRUE),
((SELECT MAX(id) FROM questions), 'To check for leaks in the evaporator core', FALSE),
((SELECT MAX(id) FROM questions), 'To measure the amount of oil in the system', FALSE);

-- ==========================================
-- A8: Engine Performance (10 New Questions)
-- ==========================================

-- Question 1
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A vehicle with a Coil-on-Plug (COP) ignition system has a misfire on cylinder 4. Swapping the coil to cylinder 3 and the spark plug to cylinder 2 results in the misfire moving to cylinder 2. What is the cause?', 'Because the misfire followed the spark plug to the new cylinder, the spark plug is proven to be the faulty component.', 'Ignition System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty ignition coil', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty spark plug', TRUE),
((SELECT MAX(id) FROM questions), 'A faulty fuel injector', FALSE),
((SELECT MAX(id) FROM questions), 'A mechanical engine problem', FALSE);

-- Question 2
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A scan tool shows a Long Term Fuel Trim (LTFT) of -18%. What does this indicate?', 'A negative fuel trim means the PCM is actively subtracting fuel from the base calculation to compensate for a rich condition (too much fuel or not enough air).', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The PCM is adding fuel to correct a lean condition', FALSE),
((SELECT MAX(id) FROM questions), 'The PCM is subtracting fuel to correct a rich condition', TRUE),
((SELECT MAX(id) FROM questions), 'The oxygen sensor is stuck lean', FALSE),
((SELECT MAX(id) FROM questions), 'There is a large vacuum leak', FALSE);

-- Question 3
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A technician suspects a restricted exhaust system (clogged catalytic converter). Which scan tool parameter is best used to verify this during a wide-open throttle (WOT) test?', 'Calculated Load or Volumetric Efficiency (VE) relies heavily on the MAF sensor. If the exhaust is restricted, the engine cannot pump air effectively, and the Calculated Load/VE will drop significantly at WOT.', 'Exhaust System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'Short Term Fuel Trim', FALSE),
((SELECT MAX(id) FROM questions), 'O2 sensor cross-counts', FALSE),
((SELECT MAX(id) FROM questions), 'Calculated Load / Volumetric Efficiency', TRUE),
((SELECT MAX(id) FROM questions), 'Idle Air Control (IAC) position', FALSE);

-- Question 4
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A vehicle has a P0442 code (EVAP System Small Leak Detected). Which tool is best suited for locating this leak?', 'A smoke machine introduces a harmless, low-pressure smoke into the EVAP system, making small leaks (like a cracked hose or loose gas cap) visually identifiable.', 'Emission Control Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A digital multimeter', FALSE),
((SELECT MAX(id) FROM questions), 'A smoke machine', TRUE),
((SELECT MAX(id) FROM questions), 'A vacuum gauge', FALSE),
((SELECT MAX(id) FROM questions), 'An exhaust gas analyzer', FALSE);

-- Question 5
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A vehicle equipped with Variable Valve Timing (VVT) sets a code for camshaft position timing over-advanced. The engine oil is very dirty and low. What is the most likely cause?', 'VVT systems rely on clean, pressurized engine oil to actuate the phasers. Low or dirty oil can cause the VVT solenoid/actuator to stick, leading to timing codes.', 'Engine Mechanical Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A stretched timing chain', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty camshaft position sensor', FALSE),
((SELECT MAX(id) FROM questions), 'Low or dirty engine oil causing a stuck VVT actuator', TRUE),
((SELECT MAX(id) FROM questions), 'A jumped timing belt', FALSE);

-- Question 6
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'On an Electronic Throttle Control (ETC) system, what happens if the two Throttle Position Sensors (TPS 1 and TPS 2) disagree by more than a calibrated amount?', 'For safety reasons, if the redundant TPS sensors disagree, the PCM cannot trust the throttle position and will put the system into a fail-safe or "limp-home" mode, severely limiting throttle opening.', 'Air Induction Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'The PCM averages the two readings', FALSE),
((SELECT MAX(id) FROM questions), 'The PCM defaults to the higher reading', FALSE),
((SELECT MAX(id) FROM questions), 'The PCM enters a fail-safe or limp-home mode', TRUE),
((SELECT MAX(id) FROM questions), 'The engine shuts off immediately and will not crank', FALSE);

-- Question 7
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'What is the primary purpose of the Exhaust Gas Recirculation (EGR) system?', 'The EGR system introduces inert exhaust gas into the intake manifold to lower peak combustion temperatures, which directly reduces the formation of Oxides of Nitrogen (NOx).', 'Emission Control Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'To reduce Hydrocarbon (HC) emissions', FALSE),
((SELECT MAX(id) FROM questions), 'To reduce Carbon Monoxide (CO) emissions', FALSE),
((SELECT MAX(id) FROM questions), 'To reduce Oxides of Nitrogen (NOx) emissions', TRUE),
((SELECT MAX(id) FROM questions), 'To increase engine horsepower', FALSE);

-- Question 8
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A stuck-closed Positive Crankcase Ventilation (PCV) valve will most likely cause:', 'A stuck-closed PCV valve prevents blow-by gases from escaping the crankcase. This causes crankcase pressure to build up, which can force oil past engine seals and gaskets.', 'Emission Control Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A lean air/fuel mixture', FALSE),
((SELECT MAX(id) FROM questions), 'Excessive crankcase pressure and oil leaks', TRUE),
((SELECT MAX(id) FROM questions), 'A high idle speed', FALSE),
((SELECT MAX(id) FROM questions), 'Coolant to mix with the engine oil', FALSE);

-- Question 9
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A returnless fuel system has higher-than-normal fuel pressure. What is the most likely cause?', 'In a returnless system, the pressure regulator is typically located in the fuel tank assembly. If it sticks closed or fails, pressure will rise above specification.', 'Fuel System Diagnosis', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A restricted fuel filter', FALSE),
((SELECT MAX(id) FROM questions), 'A weak fuel pump', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty in-tank fuel pressure regulator', TRUE),
((SELECT MAX(id) FROM questions), 'A leaking fuel injector', FALSE);

-- Question 10
INSERT INTO questions (exam_id, stem_text, explanation_text, topic, active_flag) 
VALUES ((SELECT id FROM exams WHERE code = 'A8'), 'A scan tool shows the upstream O2 sensor voltage fluctuating rapidly between 0.1V and 0.9V, while the downstream O2 sensor voltage remains relatively steady at 0.6V. What does this indicate?', 'This is the normal operation of a healthy catalytic converter. The upstream sensor switches rapidly as fuel trim adjusts, and the converter stores/releases oxygen, smoothing out the downstream signal.', 'Emission Control Systems', TRUE);

INSERT INTO question_choices (question_id, choice_text, is_correct) VALUES 
((SELECT MAX(id) FROM questions), 'A faulty upstream O2 sensor', FALSE),
((SELECT MAX(id) FROM questions), 'A faulty downstream O2 sensor', FALSE),
((SELECT MAX(id) FROM questions), 'A depleted catalytic converter', FALSE),
((SELECT MAX(id) FROM questions), 'Normal catalytic converter operation', TRUE);