lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.43027027027027 --fixed-mass2 58.00524524524525 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026922585.9193236 \
--gps-end-time 1026929785.9193236 \
--d-distr volume \
--min-distance 4251.893112282399e3 --max-distance 4251.913112282399e3 \
--l-distr fixed --longitude 92.50566101074219 --latitude 33.759986877441406 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
