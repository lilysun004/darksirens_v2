lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.578818818818819 --fixed-mass2 46.407167167167174 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022653015.6988418 \
--gps-end-time 1022660215.6988418 \
--d-distr volume \
--min-distance 1201.2983688839959e3 --max-distance 1201.3183688839958e3 \
--l-distr fixed --longitude 49.504554748535156 --latitude -3.497424364089966 --i-distr uniform \
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
