lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.178138138138138 --fixed-mass2 38.59107107107108 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007558281.2669622 \
--gps-end-time 1007565481.2669622 \
--d-distr volume \
--min-distance 1371.8397541874904e3 --max-distance 1371.8597541874904e3 \
--l-distr fixed --longitude 139.6636199951172 --latitude -2.9834134578704834 --i-distr uniform \
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
