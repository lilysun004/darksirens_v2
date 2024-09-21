lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 11.52888888888889 --fixed-mass2 51.19767767767768 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007511953.1675954 \
--gps-end-time 1007519153.1675954 \
--d-distr volume \
--min-distance 1998.4487106141012e3 --max-distance 1998.4687106141012e3 \
--l-distr fixed --longitude 33.5554084777832 --latitude 39.280067443847656 --i-distr uniform \
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
