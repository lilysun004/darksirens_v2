lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 46.07099099099099 --fixed-mass2 37.66658658658659 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1025170272.4032763 \
--gps-end-time 1025177472.4032763 \
--d-distr volume \
--min-distance 2042.7184073065928e3 --max-distance 2042.7384073065928e3 \
--l-distr fixed --longitude -133.88864135742188 --latitude 48.2120475769043 --i-distr uniform \
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
